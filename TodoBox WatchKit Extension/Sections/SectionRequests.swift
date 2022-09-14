//
//  SectionRequests.swift
//  TodoBox WatchKit Extension
//
//  Created by Ayush Kumar on 1/13/22.
//

import Foundation

func jsonToSections(_ json: Data) -> Array<Section> {
    return try! JSONDecoder().decode(Array<Section>.self, from: json)
}

func sectionToJSON(_ section: Section) -> Dictionary<String, Any> {
    return try! JSONSerialization.jsonObject(
        with: JSONEncoder().encode(section),
        options: []
    ) as! Dictionary<String, Any>
}

func getSections(_ token: String, onCompletion: @escaping (Array<Section>?) -> Void) {
    let url = "https://todobox.octalwise.com/api/sections"

    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = "GET"
    request.addValue(token, forHTTPHeaderField: "Authorization")

    let session = URLSession.shared
    let task = session.dataTask(with: request, completionHandler: { data, _, _ -> Void in
        onCompletion(jsonToSections(data!))
    })

    task.resume()
}
