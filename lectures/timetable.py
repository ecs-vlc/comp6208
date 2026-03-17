import yaml
from datetime import datetime, timedelta
from collections import deque

DAY_TO_INT = {
    "Mon": 0, "Tue": 1, "Wed": 2,
    "Thu": 3, "Fri": 4
}


def load_yaml(filename: str) -> dict:
    with open(filename, "r") as f:
        return yaml.safe_load(f)


def to_date(d: str) -> datetime:
    return datetime.strptime(d, "%Y-%m-%d")


def is_in_holiday(date: datetime, holidays: datetime) -> bool:
    for h in holidays:
        if h["start"] <= date <= h["end"]:
            return True
    return False


def get_week_start(date: datetime) -> datetime:
    return date - timedelta(days=date.weekday())


def format_date(d: datetime) -> str:
    return d.strftime("%d %b %Y")


def generate_weeks(term_start: datetime, num_weeks: int) -> list[datetime]:
    weeks = []
    current = get_week_start(term_start)

    for _ in range(num_weeks):
        week_start = current
        week_end = current + timedelta(days=4)
        weeks.append((week_start, week_end))
        current += timedelta(days=7)

    return weeks


def generate_schedule(course, weeks, holidays, bank_holidays):
    lecture_queue = deque(course["lectures"])
    schedule = []

    for week_start, week_end in weeks:
        row = []

        for slot in course["slots"]:
            day_offset = DAY_TO_INT[slot["day"]]
            lecture_date = week_start + timedelta(days=day_offset)

            if lecture_date in bank_holidays:
                row.append("BANK HOLIDAY")
            elif is_in_holiday(lecture_date, holidays):
                row.append("")  # blank for holiday
            elif lecture_queue:
                row.append(lecture_queue.popleft())
            else:
                row.append("")

        schedule.append((week_start, week_end, row))

    return schedule


def generate_html(course_name, slots, schedule):
    html = []

    #html.append(f"<h2>{course_name}</h2>")
    html.append("<table class='timetable'>")

    # Header
    html.append("<tr>")
    html.append("<th>Week</th>")
    for slot in slots:
        html.append(f"<th>{slot['day']} {slot['time']}</th>")
    html.append("</tr>")

    # Rows
    for week_start, week_end, row in schedule:
        html.append("<tr>")
        html.append(
            f"<td class='week'>{format_date(week_start)} - {format_date(week_end)}</td>"
        )

        for cell in row:
            if cell == "BANK HOLIDAY":
                html.append("<td class='bank-holiday'>Bank Holiday</td>")
            else:
                html.append(f"<td>{cell}</td>")

        html.append("</tr>")

    html.append("</table>")
    return "\n".join(html)


def generate_all_timetables(yaml_file, output_html="timetables.html", standalone=False):
    data = load_yaml(yaml_file)

    calendar = data["calendar"]

    term_start = calendar["term_start"]
    num_weeks = calendar["weeks"]

    holidays = [
        {"start": h["start"], "end": h["end"]}
        for h in calendar["holidays"]
    ]

    bank_holidays = set(d for d in calendar["bank_holidays"])

    weeks = generate_weeks(term_start, num_weeks)

    html = []
    if standalone:
        html.append("<html>")
        html.append("<head>")
        html.append("<link rel='stylesheet' href='style.css'>")
        html.append("</head>")
        html.append("<body>")

    for course in data["courses"]:
        schedule = generate_schedule(course, weeks, holidays, bank_holidays)
        html.append(generate_html(course["name"], course["slots"], schedule))

    if standalone:
        html.append("</body></html>")

    with open(output_html, "w") as f:
        f.write("\n".join(html))

    return output_html

if __name__ == '__main__':
    generate_all_timetables("courses.yaml", "lecture_timetable.html")
    generate_all_timetables("courses.yaml", "../site/lecture_timetable.html", True)
