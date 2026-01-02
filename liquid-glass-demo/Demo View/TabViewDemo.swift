//
//  TabViewDemo.swift
//  liquid-glass-demo
//
//  Created by khoasdyn on 2/1/26.
//

import SwiftUI

struct TabViewDemo: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                Text("Home")
            }
            
            Tab("Messages", systemImage: "paperplane.fill") {
                Text("Messages")
            }
            
            Tab("Profile", systemImage: "person.fill") {
                Text("Profile")
            }
            
            Tab("Search", systemImage: "magnifyingglass", role: .search) {
                NavigationStack {
                    Text("Search")
                        .searchable(text: $searchText)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Close") {
                    dismiss()
                }
            }
        }
    }
}

#Preview("Light Mode") {
    TabViewDemo()
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    TabViewDemo()
        .preferredColorScheme(.dark)
}
