import re

def extract(string: str) -> str:
    _, endpart = string.split("{")
    mid, _ = endpart.split("}")
    return mid

def link(course_name: str) -> str:
    return f"<a href=\"lectures.html#{course_name}\">{course_name}</a>"

def main() -> None:
    with open("lectures.tex", "r") as f:
        courses = [extract(line) for line in f if re.search("^\\\\lecture{", line)]
    courses = [link(course) for course in courses]
    for course in courses:
        print(f"      - {course}")

if __name__ == '__main__':
    main()
