//
//  GlassEffectContainerDemo.swift
//  liquid-glass-demo
//
//  Created by khoasdyn on 2/1/26.
//

import SwiftUI

struct GlassEffectContainerDemo: View {
    @State private var isShowingMenu: Bool = false
        
        var body: some View {
            ZStack {
                Image("background-3")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                
                GlassEffectContainer {
                    VStack {
                        if isShowingMenu {
                                Group {
                                    Image(systemName: "heart.fill")
                                        .font(.headline)
                                        .foregroundStyle(.red.gradient)
                                        .frame(width: 48, height: 48)
                                    
                                    Image(systemName: "paperplane.fill")
                                        .font(.headline)
                                        .foregroundStyle(.blue.gradient)
                                        .frame(width: 48, height: 48)
                                }
                                .glassEffect(.clear)
                        }
                        
                        Button {
                            isShowingMenu.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .font(.title)
                                .rotationEffect(isShowingMenu ? .degrees(45) : .zero)
                        }
                        .frame(width: 48, height: 48)
                        .glassEffect(.clear)
                        .padding(.bottom)
                    }
                }
                .animation(.smooth(duration: 2), value: isShowingMenu)
            }
        }
}

#Preview {
    GlassEffectContainerDemo()
}
