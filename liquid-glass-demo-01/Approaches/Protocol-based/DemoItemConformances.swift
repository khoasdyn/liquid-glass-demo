//
//  DemoItemConformances.swift
//  liquid-glass-demo
//
//  This file contains all the concrete types that conform to DemoItemProtocol.
//  Each struct represents one demo and provides its own implementation of
//  the protocol requirements.

import SwiftUI

// MARK: - Button Demo Item
struct ButtonDemoItem: DemoItemProtocol {
    
    let id = "button-demo"
    let title = "Button & Glass Effect"
    let description = "Explore the new glassEffect modifier and glass button styles"
    let iconName = "button.horizontal.fill"
    let iconColor = Color.blue
    
    func makeDestinationView() -> AnyView {
        AnyView(ButtonDemo())
    }
}

// MARK: - Tab View Demo Item
struct TabViewDemoItem: DemoItemProtocol {
    
    let id = "tabview-demo"
    let title = "Tab View"
    let description = "The redesigned TabView with the new Tab API"
    let iconName = "square.split.1x2.fill"
    let iconColor = Color.purple
    
    var requiresFullScreen: Bool {
        true
    }
    
    func makeDestinationView() -> AnyView {
        AnyView(TabViewDemo())
    }
}

// MARK: - Glass Effect Container Demo Item
struct GlassEffectContainerDemoItem: DemoItemProtocol {
    
    let id = "glass-container-demo"
    let title = "Glass Effect Container"
    let description = "Learn how to use GlassEffectContainer for grouped glass elements"
    let iconName = "square.on.square"
    let iconColor = Color.mint
    
    func makeDestinationView() -> AnyView {
        AnyView(GlassEffectContainerDemo())
    }
}

// MARK: - Glass Effect Transition Demo Item
struct GlassEffectTransitionDemoItem: DemoItemProtocol {
    
    let id = "glass-transition-demo"
    let title = "Glass Effect Transition"
    let description = "Discover transitions and animations with glass effects"
    let iconName = "arrow.right.arrow.left.square"
    let iconColor = Color.orange
    
    func makeDestinationView() -> AnyView {
        AnyView(GlassEffectTransitionDemo())
    }
}

// MARK: - Toolbar Demo Item
struct ToolbarDemoItem: DemoItemProtocol {
    
    let id = "toolbar-demo"
    let title = "Toolbar"
    let description = "Explore the new toolbar styles and placements"
    let iconName = "menubar.rectangle"
    let iconColor = Color.red
    
    func makeDestinationView() -> AnyView {
        AnyView(ToolbarDemo())
    }
}

// MARK: - Demo Registry
enum DemoRegistry {
    static let allDemosExistential: [any DemoItemProtocol] = [
        ButtonDemoItem(),
        TabViewDemoItem(),
        GlassEffectContainerDemoItem(),
        GlassEffectTransitionDemoItem(),
        ToolbarDemoItem()
    ]
}
