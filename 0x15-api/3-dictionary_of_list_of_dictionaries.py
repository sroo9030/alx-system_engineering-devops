#!/usr/bin/python3
"""
This script fetches and displays TODO list progress for all employees,
and exports the data in JSON format.
"""

import json
import requests


def fetch_all_employees_data():
    """Fetch data for all employees and their TODO lists."""
    users_url = "https://jsonplaceholder.typicode.com/users"
    todos_url = "https://jsonplaceholder.typicode.com/todos"

    users_response = requests.get(users_url).json()
    todos_response = requests.get(todos_url).json()

    return users_response, todos_response


def export_all_to_json():
    """Export all employees' TODO list data to JSON format."""
    users_data, todos_data = fetch_all_employees_data()

    tasks_by_user = {}
    for user in users_data:
        user_id = user.get("id")
        username = user.get("username")
        user_tasks = [
            {
                "username": username,
                "task": task.get("title"),
                "completed": task.get("completed")
            }
            for task in todos_data if task.get("userId") == user_id
        ]
        tasks_by_user[user_id] = user_tasks

    json_filename = "todo_all_employees.json"
    with open(json_filename, mode='w') as file:
        json.dump(tasks_by_user, file)


if __name__ == "__main__":
    export_all_to_json()
