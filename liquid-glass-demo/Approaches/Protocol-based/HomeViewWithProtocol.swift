//
//  HomeViewWithProtocol.swift
//  liquid-glass-demo
//
//  A HomeView implementation using the protocol-oriented approach.
//  This demonstrates how to work with protocol-conforming types
//  and type-erased collections in SwiftUI.

import SwiftUI

struct HomeViewWithProtocol: View {
    
    @State private var fullScreenDemo: (any DemoItemProtocol)?
    @State private var isShowingFullScreen = false

    let demos: [any DemoItemProtocol]
    
    init(demos: [any DemoItemProtocol] = DemoRegistry.allDemosExistential) {
        self.demos = demos
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(demos, id: \.id) { demo in
                    if demo.requiresFullScreen {
                        Button {
                            fullScreenDemo = demo
                            isShowingFullScreen = true
                        } label: {
                            ProtocolDemoRow(demo: demo)
                        }
                        .tint(.primary)
                    } else {
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
            .fullScreenCover(isPresented: $isShowingFullScreen) {
                if let demo = fullScreenDemo {
                    NavigationStack {
                        demo.makeDestinationView()
                    }
                }
            }
        }
    }
}

// MARK: - Demo Row Component
struct ProtocolDemoRow: View {
    
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
    let filteredDemos = DemoRegistry.allDemosExistential.filter { !$0.requiresFullScreen }
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
