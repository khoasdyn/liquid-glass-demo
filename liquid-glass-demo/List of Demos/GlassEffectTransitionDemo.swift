//
//  GlassEffectTransitionDemo.swift
//  liquid-glass-demo
//
//  Created by khoasdyn on 4/1/26.
//

import SwiftUI

struct GlassEffectTransitionDemo: View {
    @State private var isExpanded = false
    @State private var text = ""
    @Namespace var namespace2
    @Namespace var namespace
    var body: some View {
        GlassEffectContainer {
            HStack {
                Image(systemName: "photo")
                    .font(.system(size: 36))
                    .frame(width: 80, height: 80)
                    .glassEffect(.regular.tint(.teal.opacity(0.4)).interactive())
                    .glassEffectID("photo", in: namespace)
                    .onTapGesture {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }
                if isExpanded {
                    Group {
                        Image(systemName: "building.2")
                            .font(.system(size: 36))
                            .frame(width: 80, height: 80)
                            .glassEffectID("building", in: namespace)
                        Image(systemName: "fish")
                            .font(.system(size: 36))
                            .frame(width: 80, height: 80)
                            .glassEffectID("fish", in: namespace)
                    }
                    .glassEffect()
                    .glassEffectUnion(id: 1, namespace: namespace)
                    .glassEffectTransition(.matchedGeometry)
                }
            }
            HStack {
                if isExpanded{
                    TextField("Enter name", text: $text)
                        .padding()
                        .glassEffect()
                        .glassEffectID("text", in: namespace2)
                        .glassEffectTransition(.matchedGeometry)
                }
                Image(systemName: isExpanded ? "checkmark" : "plus")
                    .font(.system(size: 36))
                    .frame(width: 80, height: 80)
                    .glassEffect(.regular.interactive())
                    .glassEffectID("plus", in: namespace2)
                    .contentTransition(.symbolEffect(.replace.magic(fallback: .replace)))
                    .onTapGesture {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            ScrollView([.horizontal, .vertical]){
                Image("background")
                
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    GlassEffectTransitionDemo()
}
