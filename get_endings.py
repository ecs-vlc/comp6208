import os

def get_file_postfixes(directory):
    """
    Get all unique filename postfixes (extensions) in a directory.

    :param directory: Path to the directory to scan
    :return: A set of unique file extensions (postfixes)
    """
    if not os.path.isdir(directory):
        raise ValueError(f"The path '{directory}' is not a valid directory.")

    postfixes = set()
    for root, _, files in os.walk(directory):
        for file in files:
            _, ext = os.path.splitext(file)
            if ext:  # Only include files with an extension
                postfixes.add(ext.lower())  # Normalize to lowercase

    return postfixes


# Example usage
if __name__ == "__main__":
    directory_path = input("Enter the directory path to scan: ").strip()
    try:
        postfixes = get_file_postfixes(directory_path)
        if postfixes:
            print("Unique file postfixes in the directory:")
            for postfix in sorted(postfixes):
                print(postfix)
        else:
            print("No files with postfixes found in the directory.")
    except Exception as e:
        print(e)
