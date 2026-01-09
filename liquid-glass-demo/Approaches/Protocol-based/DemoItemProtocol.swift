//
//  DemoItemProtocol.swift
//  liquid-glass-demo
//
//  This file defines the protocol that all demo items must conform to.
//  
//  PROTOCOL-ORIENTED PROGRAMMING IN SWIFT
//  =======================================
//  Swift is often described as a "protocol-oriented" language. Unlike
//  class-based inheritance (where you inherit implementation from a parent),
//  protocols define a CONTRACT that any type can adopt.
//
//  Think of a protocol like a job description: it says "whoever takes this
//  role must be able to do X, Y, and Z" without saying HOW to do them.
//  Each conforming type provides its own implementation.
//
//  This approach promotes:
//  - Flexibility: Structs, classes, and enums can all conform
//  - Testability: You can create mock conformances for testing
//  - Composition: Types can conform to multiple protocols
//  - Decoupling: Code depends on abstractions, not concrete types
//

import SwiftUI

// MARK: - The DemoItemProtocol

/// A protocol that defines what every demo item must provide.
///
/// Any type (struct, class, or enum) that wants to be displayed in our
/// demo list must conform to this protocol by implementing all its
/// requirements.
///
/// ## Why `Identifiable` and `Hashable` Requirements?
/// We inherit from `Identifiable` so that SwiftUI's `ForEach` can
/// uniquely identify each item. We include `Hashable` so items can
/// be used with `NavigationLink(value:)` and other SwiftUI APIs.
///
/// ## The Associated Type Challenge
/// Notice we're NOT using `associatedtype` for the destination view.
/// If we wrote `associatedtype DestinationView: View`, this protocol
/// would have an "associated type" making it a "PAT" (Protocol with
/// Associated Type). PATs cannot be used as types directly - you can't
/// write `var items: [DemoItemProtocol]` with a PAT.
///
/// Instead, we use a method that returns `AnyView`, which is a form
/// of type erasure that allows us to store different conforming types
/// in the same collection.
protocol DemoItemProtocol: Identifiable, Hashable {
    
    /// A unique identifier for this demo item.
    /// The `Identifiable` protocol requires this, but we make it
    /// explicit here with a concrete type (String) for clarity.
    var id: String { get }
    
    /// The display title shown in the list row.
    var title: String { get }
    
    /// A brief description explaining what this demo showcases.
    var description: String { get }
    
    /// The SF Symbol name for the icon displayed in the row.
    var iconName: String { get }
    
    /// The color used for the icon and its background tint.
    var iconColor: Color { get }
    
    /// Whether this demo requires full-screen presentation.
    /// Defaults to `false` via a protocol extension below.
    var requiresFullScreen: Bool { get }
    
    /// Creates and returns the destination view for this demo.
    ///
    /// This is a METHOD rather than a computed property returning
    /// `some View` because we need to return `AnyView` to allow
    /// storing heterogeneous conforming types together.
    ///
    /// Each conforming type implements this to return its specific
    /// destination view, wrapped in AnyView.
    func makeDestinationView() -> AnyView
}

// MARK: - Protocol Extension (Default Implementations)

/// Protocol extensions let you provide default implementations.
///
/// This is one of Swift's most powerful features! Instead of forcing
/// every conforming type to implement every requirement, you can
/// provide sensible defaults that types can override if needed.
///
/// This is similar to "mixins" or "traits" in other languages.
extension DemoItemProtocol {
    
    /// Default: demos don't require full-screen presentation.
    ///
    /// Types that need full-screen can override this by providing
    /// their own `requiresFullScreen` property that returns `true`.
    var requiresFullScreen: Bool {
        false
    }
    
    /// Default hash implementation using just the id.
    ///
    /// Since `id` is unique, this is sufficient for most cases.
    /// Conforming types can override if they need different behavior.
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    /// Default equality implementation comparing ids.
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Type Eraser Wrapper

/// A type-erased wrapper that can hold any `DemoItemProtocol` conformer.
///
/// ## Why Do We Need This?
///
/// Here's the problem: we want to store different types that conform
/// to `DemoItemProtocol` in the same array. But in Swift, you can't
/// just write `[DemoItemProtocol]` and put different concrete types
/// in it... well, actually in Swift 5.7+ you CAN with `any` keyword,
/// but there are limitations.
///
/// The classic solution is a "type eraser" - a concrete type that
/// wraps any conformer and forwards all protocol requirements to it.
///
/// Think of it like a universal remote control: the remote (AnyDemoItem)
/// has all the buttons (protocol requirements), and inside it holds
/// the actual device (the conforming type) that responds to those buttons.
///
/// ## The Pattern
/// 1. Store the wrapped value as `any DemoItemProtocol`
/// 2. Implement all protocol requirements by forwarding to the wrapped value
/// 3. Make the wrapper itself conform to the protocol
///
struct AnyDemoItem: DemoItemProtocol {
    
    // MARK: - Stored Properties
    
    /// The wrapped demo item, stored as an existential type.
    ///
    /// `any DemoItemProtocol` means "some concrete type that conforms
    /// to DemoItemProtocol, but I don't know (or care) which one."
    /// This is called an "existential" in Swift terminology.
    private let wrapped: any DemoItemProtocol
    
    // MARK: - Initializer
    
    /// Creates a type-erased wrapper around any conforming type.
    ///
    /// The generic constraint `<T: DemoItemProtocol>` ensures we only
    /// accept types that actually conform to our protocol.
    init<T: DemoItemProtocol>(_ item: T) {
        self.wrapped = item
    }
    
    // MARK: - Protocol Conformance (Forwarding)
    
    // Each of these simply forwards to the wrapped value.
    // This is the "erasure" - the outside world sees AnyDemoItem,
    // but all the actual work is done by whatever's inside.
    
    var id: String {
        wrapped.id
    }
    
    var title: String {
        wrapped.title
    }
    
    var description: String {
        wrapped.description
    }
    
    var iconName: String {
        wrapped.iconName
    }
    
    var iconColor: Color {
        wrapped.iconColor
    }
    
    var requiresFullScreen: Bool {
        wrapped.requiresFullScreen
    }
    
    func makeDestinationView() -> AnyView {
        wrapped.makeDestinationView()
    }
    
    // MARK: - Hashable (Special Handling)
    
    /// We need custom Hashable because `any DemoItemProtocol` isn't
    /// automatically Hashable in a way Swift can synthesize.
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: AnyDemoItem, rhs: AnyDemoItem) -> Bool {
        lhs.id == rhs.id
    }
}
