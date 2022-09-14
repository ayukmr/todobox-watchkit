//
//  Requests.swift
//  TodoBox WatchKit Extension
//
//  Created by Ayush Kumar on 1/8/22.
//

import Foundation

func jsonToTasks(_ json: Data) -> Array<Task> {
    return try! JSONDecoder().decode(Array<Task>.self, from: json)
}

func taskToJSON(_ task: Task) -> Dictionary<String, Any> {
    return try! JSONSerialization.jsonObject(
        with: JSONEncoder().encode(task),
        options: []
    ) as! Dictionary<String, Any>
}

func getTasks(_ token: String, onCompletion: @escaping (Array<Task>?) -> Void) {
    let url = "https://todobox.octalwise.com/api/tasks"

    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = "GET"
    request.addValue(token, forHTTPHeaderField: "Authorization")

    let session = URLSession.shared
    let task = session.dataTask(with: request, completionHandler: { data, _, _ -> Void in
        onCompletion(jsonToTasks(data!))
    })

    task.resume()
}

func createTask(token: String, task: Task, onCompletion: @escaping () -> Void) {
    let json = taskToJSON(task)

    let url = "https://todobox.octalwise.com/api/task"
    var request = URLRequest(url: URL(string: url)!)

    request.httpMethod = "POST"
    request.httpBody = try! JSONSerialization.data(withJSONObject: json, options: [])
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue(token, forHTTPHeaderField: "Authorization")

    let session = URLSession.shared
    let task = session.dataTask(with: request, completionHandler: { _, _, _ in onCompletion() })

    task.resume()
}

func updateTask(token: String, task: Task, id: String, onCompletion: @escaping () -> Void) {
    let json = taskToJSON(task)

    let url = "https://todobox.octalwise.com/api/task/\(id)"
    var request = URLRequest(url: URL(string: url)!)

    request.httpMethod = "PUT"
    request.httpBody = try! JSONSerialization.data(withJSONObject: json, options: [])
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue(token, forHTTPHeaderField: "Authorization")

    let session = URLSession.shared
    let task = session.dataTask(with: request, completionHandler: { _, _, _ in onCompletion() })

    task.resume()
}

func removeTask(token: String, id: String, onCompletion: @escaping () -> Void) {
    let url = "https://todobox.octalwise.com/api/task/\(id)"

    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = "DELETE"
    request.addValue(token, forHTTPHeaderField: "Authorization")

    let session = URLSession.shared
    let task = session.dataTask(with: request, completionHandler: { _, _, _ in onCompletion() })

    task.resume()
}
