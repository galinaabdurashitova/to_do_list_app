//
//  TaskListView.swift
//  ToDoList
//
//  Created by Galina Abdurashitova on 30.05.2025.
//

import SwiftUI

struct TaskListView: View {
    // MARK: - Properties
    @StateObject var viewModel: TaskListViewModel = TaskListViewModel()

    // MARK: - Body
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                Text("Tasks")
                    .font(.title)
                    .fontWeight(.black)
                    .fontWidth(.expanded)
                
                tasksList
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            NewTaskInputView(addTaskAction: viewModel.addTask)
        }
    }
    
    // MARK: - Subviews
    
    @ViewBuilder
    private var tasksList: some View {
        if viewModel.tasks.isEmpty {
            EmptyStateView()
                .accessibilityIdentifier("EmptyStateTitle")
        } else {
            List(viewModel.tasks, id: \.id) { task in
                taskLine(task)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            viewModel.deleteTask(id: task.id)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .accessibilityIdentifier("TaskList")
        }
    }
    
    private func taskLine(_ task: Task) -> some View {
        HStack {
            Text(task.title)
                .strikethrough(task.isDone, color: .primary)
                .opacity(task.isDone ? 0.6 : 1)
                .accessibilityLabel("TaskTitle-\(task.title)")
            Spacer()
            doneButton(task: task)
        }
        .padding(16)
        .background(task.isDone ? .green.opacity(0.4) : Color(.systemGray6))
        .cornerRadius(16)
        .onTapGesture {
            viewModel.toggleDone(id: task.id)
        }
        .accessibilityElement()
        .accessibilityAddTraits(.isButton)
        .accessibilityIdentifier("Toggle-\(task.title)-\(task.isDone ? "checkmark" : "circle")")
    }
    
    private func doneButton(task: Task) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemGray4).opacity(0.8))
                .frame(width: 24, height: 24)
            if task.isDone {
                CustomCheckMark()
            }
        }
    }
}

#Preview {
    TaskListView()
}
