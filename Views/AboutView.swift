//
//  AboutView.swift
//  SXCleanBy
//
//  Created by Evan Matthew on 23/3/25.
//

import SwiftUI

struct AboutView: View {
    private let accentColor = Color.red
    private let startColor = Color.green
    private let secondaryColor = Color.gray.opacity(0.2)
    var body: some View {
        CustomVisualEffectBlur.dark
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
            .frame(width: 400, height: 300)
            
            .edgesIgnoringSafeArea(.all)
            .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
            .padding()
    }
     
        
}

