//
//  TaskTests.swift
//  TodoBox WatchKit Extension
//
//  Created by Ayush Kumar on 1/9/22.
//

import Foundation

func GenerateMockTask() -> Task {
    let possibleTasks = [
        Task(
            id: "0000",
            completed: true,
            name: "Task A",
            description: "Description A",
            priority: 1,
            date: 100000000,
            section: nil,
            subtasks: [
                Subtask(completed: false, name: "Subtask 0"),
                Subtask(completed: true,  name: "Subtask 1"),
                Subtask(completed: false, name: "Subtask 2"),
            ]
        ),
        Task(
            id: "1111",
            completed: false,
            name: "Task B",
            description: "Description B",
            priority: 4,
            date: nil,
            section: nil,
            subtasks: [
                Subtask(completed: false, name: "Subtask 0"),
                Subtask(completed: true,  name: "Subtask 1"),
                Subtask(completed: false, name: "Subtask 2"),
            ]
        )
    ]

    return possibleTasks.randomElement()!
}

func GenerateMockTasks(sectionIds: Array<String>?) -> Array<Task> {
    var tasks: Array<Task> = []

    for i in 0...9 {
        tasks.append(Task(
            id: "\(i)\(i)\(i)\(i)",
            completed: i % 2 == 0,
            name: "Task \(i)",
            description: "Description \(i)",
            priority: i % 4 + 1,
            date: i * i * 100000,
            section: sectionIds != nil ? sectionIds![i % sectionIds!.count] : nil,
            subtasks: [
                Subtask(completed: false, name: "Subtask 0"),
                Subtask(completed: true,  name: "Subtask 1"),
                Subtask(completed: false, name: "Subtask 2"),
            ]
        ))
    }

    return tasks
}

func GenerateMockSection() -> Section {
    let possibleSections = [
        Section(
            id: "0000",
            name: "Section A",
            icon: "bug",
            color: "#fff"
        ),
        Section(
            id: "1111",
            name: "Section B",
            color: "#0af"
        )
    ]

    return possibleSections.randomElement()!
}

func GenerateMockSections(sectionIds: Array<String>) -> Array<Section> {
    var sections: Array<Section> = []

    for (i, id) in sectionIds.enumerated() {
        sections.append(Section(
            id: id,
            name: "Section \(i)",
            color: [ "#fff", "#f00", "#0f0", "#0af", "#f0a" ].randomElement()!
        ))
    }

    return sections
}
