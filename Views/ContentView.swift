//
//  ContentView.swift
//  SXCleanBy
//
//  Created by anonym on 20.03.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            CustomVisualEffectBlur.dark // Применяем темный эффект размытия

            VStack {
                // Заголовок раздела
                Text(NSLocalizedString("Cleaner", comment: "Очистка"))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                
                Spacer()
                
                // Основной контент раздела (первый экран)
                CleanerView()
                
                Spacer()
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
    }
}
