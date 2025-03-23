//
//  FileItem.swift
//  SXCleanBy
//
//  Created by Роман Беловицкий on 20.03.2025.
//


import SwiftUI

struct FileItem: Identifiable {
    let id = UUID()
    let name: String
    let size: String
}

struct FileRowView: View {
    let file: FileItem
    let isSelected: Bool
    let toggleSelection: () -> Void

    var body: some View {
        HStack {
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .foregroundColor(.blue)
                .onTapGesture { toggleSelection() }
            
            VStack(alignment: .leading) {
                Text(file.name)
                    .font(.headline)
                Text(file.size)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
    }
}
