//
//  ToolbarDemo.swift
//  liquid-glass-demo
//
//  Created by khoasdyn on 4/1/26.
//

import SwiftUI

struct ToolbarDemo: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        List(0...20, id: \.self) { id in
            Text(id.description)
        }
        .navigationTitle("Toolbar Features")
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button {
                    // action here
                } label: {
                    HStack {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .font(.title2)
                            .padding(.leading)
                        
                        VStack {
                            Text("Filter by")
                                .font(.callout)
                            Text("Unread")
                                .font(.footnote)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            
            ToolbarSpacer(.flexible, placement: .bottomBar)
            
            ToolbarItem(placement: .bottomBar) {
                Button {
                    // action here
                } label: {
                    Image(systemName: "magnifyingglass")
                }
            }
            
            ToolbarSpacer(.fixed, placement: .bottomBar)
            
            ToolbarItem(placement: .bottomBar) {
                Button { } label: {
                    Image(systemName: "plus")
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 12) {
                    Button { } label: {
                        Image(systemName: "heart.fill")
                    }
                    
                    Button { } label: {
                        Image(systemName: "paperplane.fill")
                    }
                }
            }
            
            ToolbarSpacer(.fixed, placement: .topBarTrailing)
            
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 12) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                }
            }
        }
        
    }
}

#Preview {
    ToolbarDemo()
}
