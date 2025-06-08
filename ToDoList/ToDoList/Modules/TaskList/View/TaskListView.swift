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
    @State private var isTaskTextFieldOpened: Bool = false
    @FocusState var isFocused

    var body: some View {
        ZStack(alignment:
            isTaskTextFieldOpened ? .bottom : .bottomTrailing
        ) {
            VStack(spacing: 16) {
                Text("Tasks")
                    .font(.title)
                    .fontWeight(.black)
                    .fontWidth(.expanded)
                tasksList
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .disabled(isTaskTextFieldOpened)
            .overlay {
                if isTaskTextFieldOpened {
                    Color.black
                        .opacity(0.2)
                        .ignoresSafeArea()
                        .onTapGesture(perform: toggleTextField)
                }
            }
            
            newTaskTextField
        }
    }
    
    @ViewBuilder
    private var newTaskTextField: some View {
        ZStack {
            if isTaskTextFieldOpened {
                textFieldSheetView
            } else {
                newTaskButton
            }
        }
        .padding(isTaskTextFieldOpened ? 24 : 16)
        .ignoresSafeArea()
        .background(isTaskTextFieldOpened ? Color(.systemGray6) : .accentColor)
        .customCorner(
            corners: isTaskTextFieldOpened ? [.topLeft, .topRight] : .allCorners,
            radius: isTaskTextFieldOpened ? 24 : 60
        )
        .padding(isTaskTextFieldOpened ? 0 : 16)
    }
    
    private var newTaskButton: some View {
        Button(action: toggleTextField) {
            Image(systemName: "plus")
                .font(.system(size: 48))
                .foregroundColor(.white)
        }
        .buttonStyle(ScaledButtonStyle())
    }
    
    private var textFieldSheetView: some View {
        VStack(alignment: .trailing, spacing: 8) {
            TextField("New Task", text: $newTaskTitle, axis: .vertical)
                .accessibilityIdentifier("NewTaskInput")
                .focused($isFocused)
            Button("Add", action: addTask)
                .foregroundColor(.white)
                .fontDesign(.monospaced)
                .fontWeight(.semibold)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(newTaskTitle.isEmpty ? .gray.opacity(0.4) : .accentColor)
                .cornerRadius(20)
                .accessibilityIdentifier("AddButton")
        }
    }
    
    @ViewBuilder
    private var tasksList: some View {
        if viewModel.tasks.isEmpty {
            emptyState
        } else {
            List {
                ForEach(viewModel.tasks, id: \.id) { task in
                    taskLine(task)
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        let id = viewModel.tasks[index].id
                        viewModel.deleteTask(id: id)
                    }
                }
            }
        }
    }
    
    private func taskLine(_ task: Task) -> some View {
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
    
    private var emptyState: some View {
        VStack(spacing: 32) {
            Image(systemName: "sparkles")
                .font(.system(size: 72))
                .foregroundColor(.accentColor)
                .symbolEffect(.breathe.pulse.byLayer, options: .repeat(.continuous))
            
            Text("No tasks yet. Add one!")
                .fontDesign(.monospaced)
        }
        .opacity(0.4)
    }
    
    // MARK: - Functions
    private func toggleTextField() {
        withAnimation(.bouncy(duration: 0.3)) {
            isTaskTextFieldOpened.toggle()
            isFocused = isTaskTextFieldOpened
        }
    }
    
    private func addTask() {
        guard !newTaskTitle.isEmpty else { return }
        viewModel.addTask(title: newTaskTitle)
        toggleTextField()
        newTaskTitle = ""
    }
}

#Preview {
    TaskListView()
}
