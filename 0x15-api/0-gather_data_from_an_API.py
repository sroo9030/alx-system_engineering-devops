#!/usr/bin/python3
"""
This script fetches and displays TODO list progress for a given employee ID.
"""

import requests
import sys


def fetch_employee_data(employee_id):
    """Fetch employee name and TODO list using the provided employee ID."""
    user_url = f"https://jsonplaceholder.typicode.com/users/{employee_id}"
    todos_url = (
        f"https://jsonplaceholder.typicode.com/todos"
        f"?userId={employee_id}"
    )

    user_response = requests.get(user_url).json()
    todos_response = requests.get(todos_url).json()

    return user_response, todos_response


def display_todo_progress(employee_id):
    """Display the TODO list progress for the given employee ID."""
    user_data, todos_data = fetch_employee_data(employee_id)

    employee_name = user_data.get("name")
    total_tasks = len(todos_data)
    done_tasks = [task for task in todos_data if task.get("completed")]
    number_of_done_tasks = len(done_tasks)

    print(
        f"Employee {employee_name} is done with tasks"
        f"({number_of_done_tasks}/{total_tasks}):"
    )

    for task in done_tasks:
        print(f"\t {task.get('title')}")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: ./script.py <employee_id>")
        sys.exit(1)

    try:
        employee_id = int(sys.argv[1])
    except ValueError:
        print("Employee ID must be an integer.")
        sys.exit(1)

    display_todo_progress(employee_id)
