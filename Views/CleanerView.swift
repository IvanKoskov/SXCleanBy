//
//  CleanerView.swift
//  SXCleanBy
//
//  Created by Роман Беловицкий on 20.03.2025.
//


import SwiftUI

struct CleanerView: View {
    
    @EnvironmentObject var globalManager: GlobalDataModel
    
    @State private var isHovered = false
    @State private var selectedFiles = [String]()
    @State private var isScanning = false
    @State private var showFiles = false
    
    private let accentColor = Color.red
    private let startColor = Color.green
    private let secondaryColor = Color.gray.opacity(0.2)
    
    var body: some View {
        VStack(spacing: 20) {
            if !showFiles && !isScanning {
                // Начальный экран с кнопкой "Начать"
                VStack {
                    Button(action: {
                        
                        /*
                        
                        let cachesManager = cachesManager()
                        
                        cachesManager.initWithDefaults()
                        print(cachesManager.defaultCachesDirs)
                        */
                        
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isScanning = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isScanning = false
                                showFiles = true
                            }
                        }
                    }) {
                        Text("Начать")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 30)
                            .background(
                                Capsule()
                                    .fill(startColor)
                                    .shadow(color: startColor.opacity(0.5), radius: 8, x: 0, y: 4)
                            )
                    }
                    .onAppear {
                        
                        let cachesManager = cachesManager() //create instance of the manager declared in Obj-C Cleaning Module
                        
                        cachesManager.initWithDefaults() // Create default paths
                        
                        globalManager.allDefaultPaths = cachesManager.defaultCachesDirs
                        
                    }
                    .buttonStyle(PlainButtonStyle())
                    .overlay(
                        Capsule()
                            .stroke(startColor.opacity(0.5), lineWidth: 2)
                            .scaleEffect(isHovered ? 1.1 : 1.0)
                            .opacity(isHovered ? 0.5 : 0)
                    )
                    .scaleEffect(isHovered ? 1.05 : 1.0)
                    .onHover { hovering in
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            isHovered = hovering
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                .transition(.asymmetric(insertion: .scale, removal: .opacity))
            } else if isScanning {
                // Анимация поиска
                VStack(spacing: 20) {
                    ZStack {
                        Circle()
                            .fill(startColor.opacity(0.1))
                            .frame(width: 70, height: 70)
                        Circle()
                            .trim(from: 0, to: 0.8)
                            .stroke(startColor, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                            .frame(width: 60, height: 60)
                            .rotationEffect(.degrees(isScanning ? 360 : 0))
                            .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isScanning)
                    }
                    Text("Поиск...")
                        .foregroundColor(.primary)
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .opacity(isScanning ? 1.0 : 0.0)
                }
                .frame(maxHeight: .infinity)
                .transition(.opacity)
            } else {
                // Экран со списком файлов
                VStack(spacing: 20) {
                    Text("Очистить неиспользуемые файлы")
                        .foregroundColor(.primary)
                        .font(.system(size: 22, weight: .semibold, design: .rounded))
                        .padding(.top, 20)
                        .shadow(color: .gray.opacity(0.2), radius: 2)

                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(globalManager.allDefaultPaths, id: \.self) { file in
                                let isSelected = selectedFiles.contains(file)
                                
                                let checkmarkImage = Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(isSelected ? startColor : .gray.opacity(0.7))
                                    .scaleEffect(isSelected ? 1.1 : 1.0)
                                    .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isSelected)

                                let backgroundColor = RoundedRectangle(cornerRadius: 14)
                                    .fill(secondaryColor)
                                    .shadow(color: isSelected ? startColor.opacity(0.3) : .clear, radius: 5)

                                let stroke = RoundedRectangle(cornerRadius: 14)
                                    .stroke(startColor.opacity(isSelected ? 0.5 : 0), lineWidth: 1)

                                HStack {
                                    Text(file)
                                        .foregroundColor(.primary)
                                        .font(.system(size: 16, design: .rounded))
                                    Spacer()
                                    checkmarkImage
                                }
                                .padding()
                                .background(backgroundColor)
                                .overlay(stroke)
                                .scaleEffect(isSelected ? 1.02 : 1.0)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                        if isSelected {
                                            selectedFiles.removeAll { $0 == file }
                                        } else {
                                            selectedFiles.append(file)
                                        }
                                    }
                                }
                            }

                        }
                        .padding(.horizontal)
                    }
                    .frame(maxHeight: 300)

                    Button(action: {
                        withAnimation(.easeInOut) {
                            print("this IS \(selectedFiles)")
                            selectedFiles.removeAll()
                        }
                    }) {
                        Text("Удалить")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(isHovered ? .white : accentColor)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 30)
                            .background(
                                Capsule()
                                    .stroke(accentColor, lineWidth: 2)
                                    .background(isHovered ? accentColor : Color.clear)
                                    .animation(.easeInOut(duration: 0.2), value: isHovered)
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                    .scaleEffect(isHovered ? 1.05 : 1.0)
                    .shadow(color: accentColor.opacity(isHovered ? 0.4 : 0), radius: 8)
                    .onHover { hovering in
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            isHovered = hovering
                        }
                    }
                    .padding(.bottom, 20)
                }
                .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .opacity))
            }
        }
        .frame(maxWidth: 400)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 24)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .strokeBorder(
                    LinearGradient(
                        colors: [startColor.opacity(0.3), accentColor.opacity(0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        )
        .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
        .padding()
    }
}
