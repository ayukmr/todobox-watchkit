//
//  TasksList.swift
//  TodoBox WatchKit Extension
//
//  Created by Ayush Kumar on 1/9/22.
//

import SwiftUI

struct TasksList: View {
    let tasks: Array<Task>
    let sectionName: String
    let sectionId: String

    let loadData: () -> Void
    let token: String

    @State var addingTask = false
    @State var name: String = ""
    @State var description: String = ""

    func mainView() -> some View {
        List(tasks + [Task(
            id: "@add",
            completed: false,
            name: "Add Task",
            priority: 0,
            subtasks: []
        )]) { task in
            if task.id == "@add" {
                Button(action: {
                    withAnimation {
                        addingTask = true
                    }
                }) {
                    Text(task.name)
                }
            } else {
                NavigationLink {
                    TaskDetail(task: task, loadData: loadData, token: token)
                } label: {
                    TaskRow(task: task, loadData: loadData, token: token)
                }
            }
        }.navigationTitle(sectionName)
    }

    func inputView() -> some View {
        ScrollView {
            TextField("Name", text: $name)
            TextField("Description", text: $description)

            Button(action: {
                if name != "" {
                    createTask(
                        token: token,
                        task: Task(
                            id: "",
                            completed: false,
                            name: name,
                            description: description != "" ? description : nil,
                            priority: 4,
                            section: sectionId.starts(with: "@") ? nil : sectionId,
                            subtasks: []
                        ),
                        onCompletion: loadData
                    )

                    withAnimation {
                        addingTask = false
                    }
                }
            }) {
                HStack {
                    Image(systemName: "plus.square")
                    Text("Add Task")
                }
            }

            Button(action: {
                withAnimation {
                    addingTask = false
                }
            }) {
                Text("Cancel")
            }
        }.background(.background)
    }

    var body: some View {
        if addingTask {
            inputView()
        } else {
            mainView()
        }
    }
}

struct TasksList_Previews: PreviewProvider {
    static var previews: some View {
        TasksList(
            tasks: GenerateMockTasks(sectionIds: nil),
            sectionName: "Section",
            sectionId: "",
            loadData: {},
            token: ""
        )
    }
}
