//
//  DemoItem.swift
//  liquid-glass-demo
//
//  A struct-based alternative to the enum approach for defining demo items.
//  This demonstrates how to use closures and type erasure to store
//  heterogeneous view types in a uniform data structure.
//

import SwiftUI

// MARK: - The DemoItem Struct

/// A struct that represents a single demo item in our list.
///
/// Unlike an enum where each case is a distinct compile-time entity,
/// a struct is a blueprint for creating instances at runtime. Each
/// instance holds its own data in stored properties.
///
/// The key insight here is that we store the destination view as a
/// CLOSURE that returns AnyView, rather than storing the view directly.
/// This solves the "different view types" problem through type erasure.
struct DemoItem: Identifiable, Hashable {
    
    // MARK: - Stored Properties
    
    /// A unique identifier for this demo item.
    /// We use UUID to guarantee uniqueness, but you could also use
    /// a String identifier if you prefer human-readable IDs.
    let id: UUID
    
    /// The display title shown in the list.
    let title: String
    
    /// A brief explanation of what this demo showcases.
    let description: String
    
    /// The SF Symbol name for the icon.
    let iconName: String
    
    /// The color used for the icon and its background.
    let iconColor: Color
    
    /// Whether this demo should be presented as a full-screen cover
    /// instead of a regular navigation push.
    let requiresFullScreen: Bool
    
    /// A closure that creates and returns the destination view.
    ///
    /// Why a closure instead of a stored view?
    /// 1. Views in SwiftUI are structs, and we want to create fresh
    ///    instances each time (views might have their own @State).
    /// 2. We can't store different view types in the same property,
    ///    but we CAN store closures that return AnyView.
    /// 3. The closure is only called when we actually need the view,
    ///    which is a form of lazy evaluation.
    ///
    /// The @escaping attribute isn't needed here because we're storing
    /// the closure in a property (it escapes by definition when stored).
    private let makeDestination: () -> AnyView
    
    // MARK: - Initializer
    
    /// Creates a new DemoItem with all its configuration.
    ///
    /// Notice the generic parameter `Destination: View` on this initializer.
    /// This is a powerful pattern: the initializer accepts ANY View type,
    /// but internally wraps it in AnyView for storage. This means callers
    /// don't need to worry about AnyView - they just pass their view.
    ///
    /// - Parameters:
    ///   - id: A unique identifier (defaults to a new UUID)
    ///   - title: The display title
    ///   - description: A brief description
    ///   - iconName: SF Symbol name
    ///   - iconColor: Color for the icon
    ///   - requiresFullScreen: Whether to use fullScreenCover
    ///   - destination: A closure that creates the destination view
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
    
    // MARK: - Computed Properties
    
    /// Returns the destination view for navigation.
    ///
    /// This is a computed property that calls our stored closure.
    /// Each call creates a fresh view instance, which is important
    /// because SwiftUI views might have @State that should be reset.
    var destinationView: AnyView {
        makeDestination()
    }
    
    // MARK: - Hashable Conformance
    
    /// We need to implement Hashable manually because closures
    /// cannot be automatically hashed.
    ///
    /// We only hash the `id` since it uniquely identifies each item.
    /// This is safe because we don't expect two DemoItems with the
    /// same ID to have different content.
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    /// Similarly, we implement Equatable (required by Hashable)
    /// by comparing only the IDs.
    static func == (lhs: DemoItem, rhs: DemoItem) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Demo Items Collection

/// A namespace for organizing our demo items.
///
/// Using an enum with no cases as a namespace is a common Swift pattern.
/// It groups related static members without allowing instantiation.
/// You could also use a struct with a private init, but enum is cleaner.
enum DemoItems {
    
    /// All available demo items in display order.
    ///
    /// This is analogous to `Demo.allCases` from the enum approach,
    /// but here we explicitly create each item. This gives us more
    /// flexibility (we could filter, reorder, or load from elsewhere)
    /// but loses the automatic "all cases" feature of CaseIterable.
    static let all: [DemoItem] = [
        
        // Each item is created by calling the DemoItem initializer.
        // Notice how the `destination` closure just creates the view directly.
        // The generic initializer handles wrapping it in AnyView for us.
        
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
            requiresFullScreen: true,  // This one needs full screen!
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
