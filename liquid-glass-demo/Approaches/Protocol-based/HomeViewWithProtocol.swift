//
//  HomeViewWithProtocol.swift
//  liquid-glass-demo
//
//  A HomeView implementation using the protocol-oriented approach.
//  This demonstrates how to work with protocol-conforming types
//  and type-erased collections in SwiftUI.
//

import SwiftUI

// MARK: - Home View (Protocol-Oriented Version)

struct HomeViewWithProtocol: View {
    
    // MARK: - State
    
    /// The demo currently shown in full-screen mode, if any.
    ///
    /// We use `AnyDemoItem?` because that's the type-erased wrapper
    /// that all our demos are stored as. This works with SwiftUI's
    /// `fullScreenCover(item:)` because `AnyDemoItem` is `Identifiable`.
    @State private var fullScreenDemo: AnyDemoItem?
    
    /// The list of demos to display.
    ///
    /// By accepting this as a parameter, we enable:
    /// - Testing with mock demos
    /// - Different demo lists in different contexts
    /// - Filtering or reordering at the call site
    let demos: [AnyDemoItem]
    
    // MARK: - Initializer
    
    /// Creates the home view with a list of demos.
    ///
    /// - Parameter demos: The demos to display. Defaults to all registered demos.
    init(demos: [AnyDemoItem] = DemoRegistry.allDemos) {
        self.demos = demos
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            List {
                // We iterate over our array of AnyDemoItem.
                // Because AnyDemoItem conforms to Identifiable (via the protocol),
                // ForEach can uniquely identify each item.
                ForEach(demos) { demo in
                    // Check the demo's requiresFullScreen property to decide
                    // which navigation style to use.
                    if demo.requiresFullScreen {
                        // Full-screen demos: Use a Button that sets state
                        Button {
                            fullScreenDemo = demo
                        } label: {
                            // We pass the demo to our row view.
                            // The row view accepts `any DemoItemProtocol`,
                            // and AnyDemoItem conforms to that protocol.
                            ProtocolDemoRow(demo: demo)
                        }
                        .tint(.primary)
                    } else {
                        // Regular navigation: Use NavigationLink
                        //
                        // Similar to the struct approach, we use the
                        // destination-based NavigationLink because our
                        // destination is AnyView, which doesn't work well
                        // with the value-based navigation pattern.
                        NavigationLink {
                            demo.makeDestinationView()
                        } label: {
                            ProtocolDemoRow(demo: demo)
                        }
                    }
                }
                .alignmentGuide(.listRowSeparatorLeading) { dimension in
                    dimension[.leading]
                }
            }
            .navigationTitle("Liquid Glass Demos")
            .fullScreenCover(item: $fullScreenDemo) { demo in
                NavigationStack {
                    demo.makeDestinationView()
                }
            }
        }
    }
}

// MARK: - Demo Row Component

/// A row view that displays any type conforming to DemoItemProtocol.
///
/// ## Using `any DemoItemProtocol` as a Parameter
///
/// The parameter type `any DemoItemProtocol` is an "existential type."
/// It means "I accept any concrete type that conforms to this protocol."
///
/// This is the power of protocol-oriented design: this row view doesn't
/// know or care whether it's displaying a `ButtonDemoItem`, a `TabViewDemoItem`,
/// or even our `AnyDemoItem` wrapper. It just needs something that provides
/// the required properties (title, description, iconName, iconColor).
///
/// This decoupling means:
/// - You could add new demo types without changing this view
/// - You could use this row in different contexts with different conformers
/// - Testing is easy: create a mock conformer with test data
struct ProtocolDemoRow: View {
    
    /// The demo item to display.
    ///
    /// Using `any DemoItemProtocol` means this view is flexible -
    /// it works with any conforming type.
    let demo: any DemoItemProtocol
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon with tinted background
            Image(systemName: demo.iconName)
                .font(.title2)
                .foregroundStyle(demo.iconColor)
                .frame(width: 44, height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(demo.iconColor.opacity(0.15))
                )
            
            // Title and description
            VStack(alignment: .leading, spacing: 4) {
                Text(demo.title)
                    .font(.headline)
                
                Text(demo.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Previews

#Preview("All Demos") {
    HomeViewWithProtocol()
}

#Preview("Filtered Demos") {
    // Demonstrate filtering: show only non-full-screen demos
    let filteredDemos = DemoRegistry.allDemos.filter { !$0.requiresFullScreen }
    return HomeViewWithProtocol(demos: filteredDemos)
}

#Preview("Single Demo Row") {
    // We can preview the row with any conforming type directly!
    // No need to wrap in AnyDemoItem for the row view.
    List {
        ProtocolDemoRow(demo: ButtonDemoItem())
        ProtocolDemoRow(demo: TabViewDemoItem())
    }
}
