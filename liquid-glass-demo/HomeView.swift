//
//  HomeView.swift
//  liquid-glass-demo
//
//  Created by khoasdyn on 2/1/26.
//

import SwiftUI

// MARK: - Home View
struct HomeView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(Demo.allCases) { demo in
                    NavigationLink(value: demo) {
                        DemoRow(demo: demo)
                    }
                }
                .alignmentGuide(.listRowSeparatorLeading) { dimension in
                    dimension[.leading]
                }
            }
            .navigationDestination(for: Demo.self) { demo in
                demo.destinationView
            }
            .navigationTitle("Liquid Glass Demos")
        }
    }
}

// MARK: - Demo Row Component
struct DemoRow: View {
    let demo: Demo
    
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

// MARK: - Preview
#Preview {
    HomeView()
}
