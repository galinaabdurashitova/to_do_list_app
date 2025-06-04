//
//  TaskListView.swift
//  ToDoList
//
//  Created by Galina Abdurashitova on 30.05.2025.
//

import SwiftUI

struct TaskListView: View {
    @StateObject var viewModel: TaskListViewModel = TaskListViewModel()
    @State private var newTaskTitle: String = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("New Task", text: $newTaskTitle)
                        .accessibilityIdentifier("NewTaskInput")
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Add") {
                        guard !newTaskTitle.isEmpty else { return }
                        viewModel.addTask(title: newTaskTitle)
                        newTaskTitle = ""
                    }
                    .accessibilityIdentifier("AddButton")
                }.padding()

                List(viewModel.tasks, id: \.id) { task in
                    HStack {
                        Text(task.title)
                            .accessibilityIdentifier(task.title)
                        Spacer()
                        Image(
                            systemName: task.isDone
                                ? "checkmark.circle.fill" : "circle"
                        )
                        .accessibilityIdentifier(
                            "Toggle-\(task.title)-\(task.isDone ? "checkmark" : "circle")"
                        )
                        .onTapGesture {
                            viewModel.toggleDone(id: task.id)
                        }
                    }
                }
            }
            .navigationTitle("Tasks")
        }
    }
}

#Preview {
    TaskListView()
}
