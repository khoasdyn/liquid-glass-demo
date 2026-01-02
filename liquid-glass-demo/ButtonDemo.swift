//
//  ButtonDemo.swift
//  liquid-glass-demo
//
//  Created by khoasdyn on 2/1/26.
//

import SwiftUI

struct ButtonDemo: View {
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            
            VStack(spacing: 24) {
                Button {
                    // action
                } label: {
                    Label("Download", systemImage: "arrow.down.circle")
                        .font(.title2.weight(.medium))
                }
                .buttonStyle(.glassProminent)
                
                Button {
                    // action
                } label: {
                    Label("Fasted Download", systemImage: "bolt")
                        .font(.title2.weight(.medium))
                }
                .buttonStyle(.glassProminent)
                .tint(.green)
                
                Button {
                    // action
                } label: {
                    Label("FAQ", systemImage: "questionmark.circle")
                        .font(.title2.weight(.medium))
                }
                .buttonStyle(.glass)
                
                HStack(spacing: 24) {
                    Image(systemName: "heart.fill")
                        .font(.title)
                        .foregroundStyle(.red.gradient)
                        .frame(width: 64, height: 64)
                        .glassEffect(.regular)
                    
                    Image(systemName: "tray.badge.fill")
                        .font(.title)
                        .foregroundStyle(.white)
                        .frame(width: 64, height: 64)
                        .glassEffect(.clear.tint(.red.opacity(0.25)))
                    
                    Image(systemName: "sparkle.text.clipboard.fill")
                        .font(.title)
                        .foregroundStyle(.blue.gradient)
                        .frame(width: 64, height: 64)
                        .glassEffect(.regular.interactive())
                }
            }
            
            
        }
        
        
    }
}

#Preview {
    ButtonDemo()
}
