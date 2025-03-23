//
//  VisualEffectBlur.swift
//  SXCleanBy
//
//  Created by Роман Беловицкий on 20.03.2025.
//


import SwiftUI
import AppKit

struct CustomVisualEffectBlur: NSViewRepresentable {
    let blurStyle: NSVisualEffectView.Material

    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = blurStyle
        view.blendingMode = .behindWindow
        view.state = .active
        return view
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {}
}

extension CustomVisualEffectBlur {
    // Используем существующие материалы для macOS
    static var dark: CustomVisualEffectBlur {
        CustomVisualEffectBlur(blurStyle: .dark) // Темный материал
    }

    static var light: CustomVisualEffectBlur {
        CustomVisualEffectBlur(blurStyle: .light) // Светлый материал
    }
}
