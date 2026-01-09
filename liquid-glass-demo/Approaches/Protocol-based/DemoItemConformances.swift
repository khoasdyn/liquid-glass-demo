//
//  DemoItemConformances.swift
//  liquid-glass-demo
//
//  This file contains all the concrete types that conform to DemoItemProtocol.
//  Each struct represents one demo and provides its own implementation of
//  the protocol requirements.
//
//  SEPARATION OF CONCERNS
//  ======================
//  Notice how each demo's configuration is self-contained in its own type.
//  This is different from the enum approach where all demos share one type
//  with switch statements. Here, each demo "owns" its own data.
//
//  Benefits:
//  - Each demo can be modified independently
//  - Different developers can work on different demos without conflicts
//  - Easy to add new demos without modifying existing code (Open-Closed Principle)
//  - Each demo could have additional properties specific to itself
//
//  Drawbacks:
//  - More files/types to manage
//  - No compile-time guarantee that all demos are included in the list
//  - Slightly more boilerplate per demo
//

import SwiftUI

// MARK: - Button Demo Item

/// Configuration for the Button & Glass Effect demo.
///
/// This struct encapsulates everything about the button demo:
/// its metadata (title, description, icon) and its destination view.
struct ButtonDemoItem: DemoItemProtocol {
    
    // We use a static constant for the ID to ensure consistency.
    // This also makes it easy to reference this specific demo elsewhere.
    let id = "button-demo"
    
    let title = "Button & Glass Effect"
    
    let description = "Explore the new glassEffect modifier and glass button styles"
    
    let iconName = "button.horizontal.fill"
    
    let iconColor = Color.blue
    
    // Note: We don't need to specify `requiresFullScreen` because
    // the protocol extension provides a default of `false`.
    
    /// Creates the destination view for this demo.
    ///
    /// We wrap ButtonDemo() in AnyView to satisfy the protocol.
    /// This is the type erasure that allows all demos to have
    /// the same return type despite having different actual views.
    func makeDestinationView() -> AnyView {
        AnyView(ButtonDemo())
    }
}

// MARK: - Tab View Demo Item

/// Configuration for the Tab View demo.
///
/// This demo is special because it requires full-screen presentation.
/// Notice how we override the default `requiresFullScreen` value.
struct TabViewDemoItem: DemoItemProtocol {
    
    let id = "tabview-demo"
    
    let title = "Tab View"
    
    let description = "The redesigned TabView with the new Tab API"
    
    let iconName = "square.split.1x2.fill"
    
    let iconColor = Color.purple
    
    /// This demo overrides the default to require full-screen.
    ///
    /// The protocol extension provides `false` as the default,
    /// but by defining this property here, we override that default.
    /// This is how protocol extensions enable "optional" requirements
    /// with sensible defaults.
    var requiresFullScreen: Bool {
        true
    }
    
    func makeDestinationView() -> AnyView {
        AnyView(TabViewDemo())
    }
}

// MARK: - Glass Effect Container Demo Item

/// Configuration for the Glass Effect Container demo.
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

/// Configuration for the Glass Effect Transition demo.
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

/// Configuration for the Toolbar demo.
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

/// A central registry of all available demo items.
///
/// This serves a similar purpose to `Demo.allCases` in the enum approach
/// or `DemoItems.all` in the struct approach. The difference is that
/// here we're collecting instances of DIFFERENT types, unified through
/// our type-eraser `AnyDemoItem`.
///
/// ## Why a Separate Registry?
///
/// We could have each conforming type register itself somewhere, but
/// that adds complexity. A simple static list is pragmatic and clear.
///
/// In a larger app, you might use:
/// - Dependency injection to provide this list
/// - A service that discovers conforming types at runtime
/// - Feature flags to include/exclude certain demos
///
/// ## Using AnyDemoItem
///
/// Notice that we wrap each concrete type in `AnyDemoItem()`.
/// This type-eraser allows us to store `ButtonDemoItem`, `TabViewDemoItem`,
/// etc. in the same array despite them being different types.
///
enum DemoRegistry {
    
    /// All available demos, wrapped in the type-eraser for uniform storage.
    ///
    /// Each demo is created as its concrete type (e.g., `ButtonDemoItem()`),
    /// then wrapped in `AnyDemoItem()` to erase the specific type.
    static let allDemos: [AnyDemoItem] = [
        AnyDemoItem(ButtonDemoItem()),
        AnyDemoItem(TabViewDemoItem()),
        AnyDemoItem(GlassEffectContainerDemoItem()),
        AnyDemoItem(GlassEffectTransitionDemoItem()),
        AnyDemoItem(ToolbarDemoItem())
    ]
    
    /// An alternative using Swift 5.7+ `any` keyword directly.
    ///
    /// With modern Swift, you can also store existentials directly
    /// in an array without a custom type-eraser wrapper. However,
    /// you lose some capabilities (like Hashable conformance) that
    /// our AnyDemoItem wrapper provides.
    ///
    /// This is shown for educational purposes - we use `allDemos` above.
    static let allDemosExistential: [any DemoItemProtocol] = [
        ButtonDemoItem(),
        TabViewDemoItem(),
        GlassEffectContainerDemoItem(),
        GlassEffectTransitionDemoItem(),
        ToolbarDemoItem()
    ]
}
