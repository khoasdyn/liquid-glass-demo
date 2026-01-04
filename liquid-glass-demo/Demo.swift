//
//  Demo.swift
//  liquid-glass-demo
//
//  Created by khoasdyn on 2/1/26.
//

import SwiftUI

enum Demo: String, CaseIterable, Identifiable, Hashable {
    case button
    case tabView
    case glassEffectContainer
    case glassEffectTransition
    case toolbar
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .button:
            return "Button & Glass Effect"
        case .tabView:
            return "Tab View"
        case .glassEffectContainer:
            return "Glass Effect Container"
        case .glassEffectTransition:
            return "Glass Effect Transition"
        case .toolbar:
            return "Toolbar"
        }
    }
    
    var description: String {
        switch self {
        case .button:
            return "Explore the new glassEffect modifier and glass button styles"
        case .tabView:
            return "The redesigned TabView with the new Tab API"
        case .glassEffectContainer:
            return "Learn how to use GlassEffectContainer for grouped glass elements"
        case .glassEffectTransition:
            return "Discover transitions and animations with glass effects"
        case .toolbar:
            return "Explore the new toolbar styles and placements"
        }
    }
    
    var iconName: String {
        switch self {
        case .button:
            return "button.horizontal.fill"
        case .tabView:
            return "square.split.1x2.fill"
        case .glassEffectContainer:
            return "square.on.square"
        case .glassEffectTransition:
            return "arrow.right.arrow.left.square"
        case .toolbar:
            return "menubar.rectangle"
        }
    }
    
    var iconColor: Color {
        switch self {
        case .button:
            return .blue
        case .tabView:
            return .purple
        case .glassEffectContainer:
            return .mint
        case .glassEffectTransition:
            return .orange
        case .toolbar:
            return .red
        }
    }
    
    var requiresFullScreen: Bool {
        switch self {
        case .tabView:
            return true
        case .button, .glassEffectContainer, .glassEffectTransition, .toolbar:
            return false
        }
    }
    
    @ViewBuilder
    var destinationView: some View {
        switch self {
        case .button:
            ButtonDemo()
        case .tabView:
            TabViewDemo()
        case .glassEffectContainer:
            GlassEffectContainerDemo()
        case .glassEffectTransition:
            GlassEffectTransitionDemo()
        case .toolbar:
            ToolbarDemo()
        }
    }
}
