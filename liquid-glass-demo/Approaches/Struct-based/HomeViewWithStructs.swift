//
//  HomeViewWithStructs.swift
//  liquid-glass-demo
//
//  An alternative HomeView implementation that uses the struct-based

import SwiftUI

// MARK: - Home View

struct HomeViewWithStructs: View {
    @State private var fullScreenDemo: DemoItem?
    let demos: [DemoItem]
    
    init(demos: [DemoItem] = DemoItems.all) {
        self.demos = demos
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(demos) { demo in
                    if demo.requiresFullScreen {
                        Button {
                            fullScreenDemo = demo
                        } label: {
                            DemoItemRow(demo: demo)
                        }
                        .tint(.primary)
                    } else {
                        NavigationLink {
                            demo.destinationView
                        } label: {
                            DemoItemRow(demo: demo)
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
                    demo.destinationView
                }
            }
        }
    }
}

// MARK: - Demo Row Component
struct DemoItemRow: View {
    let demo: DemoItem
    
    var body: some View {
        HStack(spacing: 16) {
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


#Preview("Default Demos") {
    HomeViewWithStructs()
}

#Preview("Custom Subset") {
    // This preview shows how easy it is to pass a custom list!
    // You could filter demos, show only certain ones, etc.
    HomeViewWithStructs(demos: Array(DemoItems.all.prefix(2)))
}
