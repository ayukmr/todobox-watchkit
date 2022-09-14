//
//  Task.swift
//  TodoBox WatchKit Extension
//
//  Created by Ayush Kumar on 1/8/22.
//

import Foundation

struct Task: Hashable, Codable, Identifiable {
    let id:          String
    let completed:   Bool
    let name:        String
    var description: String?
    let priority:    Int
    var date:        Int?
    var section:     String?
    let subtasks:    Array<Subtask>

    func toggle() -> Task {
        return Task(
            id:          self.id,
            completed:   !self.completed,
            name:        self.name,
            description: self.description,
            priority:    self.priority,
            date:        self.date,
            section:     self.section,
            subtasks:    self.subtasks
        )
    }
}

struct Subtask: Hashable, Codable {
    let completed: Bool
    let name:      String
}

struct Section: Hashable, Codable, Identifiable {
    let id:    String
    let name:  String
    var icon:  String?
    let color: String
}
