//
//  Task.swift
//  ToDoList
//
//  Created by Galina Abdurashitova on 04.06.2025.
//

import Foundation

struct Task: Identifiable, Equatable {
    let id: UUID
    let title: String
    let isDone: Bool
}
