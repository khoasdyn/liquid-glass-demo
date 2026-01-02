//
//  Demo.swift
//  liquid-glass-demo
//
//  Created by khoasdyn on 2/1/26.
//

import SwiftUI

enum Demo: String, CaseIterable, Identifiable, Hashable {
    case button
    case tabView
    
    // MARK: - Identifiable Conformance
    /// Using `self` means each enum case is its own unique identifier.
    var id: Self { self }
    
    // MARK: - Display Properties
    var title: String {
        switch self {
        case .button:
            return "Button & Glass Effect"
        case .tabView:
            return "Tab View"
        }
    }
    
    var description: String {
        switch self {
        case .button:
            return "Explore the new glassEffect modifier and glass button styles"
        case .tabView:
            return "The redesigned TabView with the new Tab API"
        }
    }
    
    var iconName: String {
        switch self {
        case .button:
            return "button.horizontal.fill"
        case .tabView:
            return "square.split.1x2.fill"
        }
    }
    
    var iconColor: Color {
        switch self {
        case .button:
            return .blue
        case .tabView:
            return .purple
        }
    }
    
    // MARK: - View Builder
    /// Returns the destination view for navigation.
    @ViewBuilder
    var destinationView: some View {
        switch self {
        case .button:
            ButtonDemo()
        case .tabView:
            TabViewDemo()
        }
    }
}
