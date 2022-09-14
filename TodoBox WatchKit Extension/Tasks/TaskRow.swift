//
//  TaskRow.swift
//  TodoBox WatchKit Extension
//
//  Created by Ayush Kumar on 1/9/22.
//

import SwiftUI

struct TaskRow: View {
    let task: Task
    let loadData: () -> Void
    let token: String

    var body: some View {
        HStack {
            Image(systemName: task.completed ? "checkmark.square.fill" : "square")
                .foregroundColor(task.completed ? .blue : .primary)
                .onTapGesture {
                    updateTask(
                        token: token,
                        task: task.toggle(),
                        id: task.id,
                        onCompletion: loadData
                    )
                }

            Text(task.name)
                .lineLimit(1)
        }
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(task: GenerateMockTask(), loadData: {}, token: "")
    }
}
