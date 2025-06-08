//
//  NewTaskInputView.swift
//  ToDoList
//
//  Created by Galina Abdurashitova on 08.06.2025.
//

import SwiftUI

struct NewTaskInputView: View {
    @State private var newTaskTitle: String = ""
    @State private var isTaskTextFieldOpened: Bool = false
    let addTaskAction: (String) -> Void
    @FocusState var isFocused
    
    var body: some View {
        ZStack(alignment: isTaskTextFieldOpened ? .bottom : .bottomTrailing) {
            Color.black
                .opacity(isTaskTextFieldOpened ? 0.2 : 0)
                .ignoresSafeArea()
                .onTapGesture(perform: toggleTextField)
            
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
    }
    
    private var newTaskButton: some View {
        Button(action: toggleTextField) {
            Image(systemName: "plus")
                .font(.system(size: 48))
                .foregroundColor(.white)
        }
        .buttonStyle(ScaledButtonStyle())
        .accessibilityIdentifier("OpenTaskInputButton")
    }
    
    private var textFieldSheetView: some View {
        VStack(alignment: .trailing, spacing: 8) {
            TextField("New Task", text: $newTaskTitle, axis: .vertical)
                .accessibilityIdentifier("NewTaskInput")
                .focused($isFocused)
                .onSubmit(addTask)
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
    
    
    // MARK: - Functions
    private func toggleTextField() {
        withAnimation(.bouncy(duration: 0.3)) {
            isTaskTextFieldOpened.toggle()
            isFocused = isTaskTextFieldOpened
        }
    }
    
    private func addTask() {
        guard !newTaskTitle.isEmpty else { return }
        addTaskAction(newTaskTitle)
        toggleTextField()
        newTaskTitle = ""
    }
}

#Preview {
    NewTaskInputView(
        addTaskAction: { _ in }
    )
}
