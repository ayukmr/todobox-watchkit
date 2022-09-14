//
//  TaskDetail.swift
//  TodoBox WatchKit Extension
//
//  Created by Ayush Kumar on 1/9/22.
//

import SwiftUI

struct TaskDetail: View {
    let task: Task
    let loadData: () -> Void
    let token: String

    var body: some View {
        VStack {
            Text(task.name)
                .font(.system(size: 27))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .lineLimit(task.description != nil ? 1 : 2)

            if task.description != nil {
                Text(task.description!)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
            }

            Spacer()

            List(task.subtasks, id: \.self) { subtask in
                HStack {
                    Image(systemName: subtask.completed ? "checkmark.square.fill" : "square")
                        .foregroundColor(subtask.completed ? .blue : .primary)
                        .onTapGesture {/* MARK: UPDATE SUBTASK */}
                    Text(subtask.name)
                }
            }

            Button(action: {
                updateTask(
                    token: token,
                    task: task.toggle(),
                    id: task.id,
                    onCompletion: loadData
                )
            }) {
                HStack {
                    Image(systemName: "checkmark.square.fill")
                    Text("Check Task")
                }
            }.foregroundColor(.blue)

            Button(action: {
                removeTask(
                    token: token,
                    id: task.id,
                    onCompletion: loadData
                )
            }) {
                HStack {
                    Image(systemName: "trash.fill")
                    Text("Delete Task")
                }
            }.foregroundColor(.red)
        }.navigationTitle("Task")
    }
}

struct TaskDetail_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetail(task: GenerateMockTask(), loadData: {}, token: "")
    }
}
