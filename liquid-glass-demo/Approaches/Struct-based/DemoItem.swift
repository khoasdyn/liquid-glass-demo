//
//  DemoItem.swift
//  liquid-glass-demo
//
//  A struct-based alternative to the enum approach for defining demo items.
//  This demonstrates how to use closures and type erasure to store
//  heterogeneous view types in a uniform data structure.
//

import SwiftUI

struct DemoItem: Identifiable, Hashable {
    
    let id: UUID
    let title: String
    let description: String
    let iconName: String
    let iconColor: Color
    let requiresFullScreen: Bool
    private let makeDestination: () -> AnyView
    
    init<Destination: View>(
        id: UUID = UUID(),
        title: String,
        description: String,
        iconName: String,
        iconColor: Color,
        requiresFullScreen: Bool = false,
        @ViewBuilder destination: @escaping () -> Destination
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.iconName = iconName
        self.iconColor = iconColor
        self.requiresFullScreen = requiresFullScreen
        
        // Here's where the type erasure happens!
        // We take the generic Destination view and wrap it in AnyView.
        // This "erases" the specific type, allowing us to store any view.
        self.makeDestination = {
            AnyView(destination())
        }
    }
    
    var destinationView: AnyView {
        makeDestination()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: DemoItem, rhs: DemoItem) -> Bool {
        lhs.id == rhs.id
    }
}


enum DemoItems {
    
    static let all: [DemoItem] = [
                
        DemoItem(
            title: "Button & Glass Effect",
            description: "Explore the new glassEffect modifier and glass button styles",
            iconName: "button.horizontal.fill",
            iconColor: .blue,
            destination: { ButtonDemo() }
        ),
        
        DemoItem(
            title: "Tab View",
            description: "The redesigned TabView with the new Tab API",
            iconName: "square.split.1x2.fill",
            iconColor: .purple,
            requiresFullScreen: true,
            destination: { TabViewDemo() }
        ),
        
        DemoItem(
            title: "Glass Effect Container",
            description: "Learn how to use GlassEffectContainer for grouped glass elements",
            iconName: "square.on.square",
            iconColor: .mint,
            destination: { GlassEffectContainerDemo() }
        ),
        
        DemoItem(
            title: "Glass Effect Transition",
            description: "Discover transitions and animations with glass effects",
            iconName: "arrow.right.arrow.left.square",
            iconColor: .orange,
            destination: { GlassEffectTransitionDemo() }
        ),
        
        DemoItem(
            title: "Toolbar",
            description: "Explore the new toolbar styles and placements",
            iconName: "menubar.rectangle",
            iconColor: .red,
            destination: { ToolbarDemo() }
        )
    ]
}
