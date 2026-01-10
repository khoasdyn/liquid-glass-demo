//
//  DemoItemProtocol.swift
//  liquid-glass-demo

import SwiftUI

// MARK: - The DemoItemProtocol
protocol DemoItemProtocol: Identifiable, Hashable {
    
    var id: String { get }
    var title: String { get }
    var description: String { get }
    var iconName: String { get }
    var iconColor: Color { get }
    var requiresFullScreen: Bool { get }
    func makeDestinationView() -> AnyView
}

// MARK: - Protocol Extension (Default Implementations)
extension DemoItemProtocol {
    
    var requiresFullScreen: Bool {
        false
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Type Eraser Wrapper
struct AnyDemoItem: DemoItemProtocol {
    
    private let wrapped: any DemoItemProtocol
    
    init<T: DemoItemProtocol>(_ item: T) {
        self.wrapped = item
    }
        
    var id: String {
        wrapped.id
    }
    
    var title: String {
        wrapped.title
    }
    
    var description: String {
        wrapped.description
    }
    
    var iconName: String {
        wrapped.iconName
    }
    
    var iconColor: Color {
        wrapped.iconColor
    }
    
    var requiresFullScreen: Bool {
        wrapped.requiresFullScreen
    }
    
    func makeDestinationView() -> AnyView {
        wrapped.makeDestinationView()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: AnyDemoItem, rhs: AnyDemoItem) -> Bool {
        lhs.id == rhs.id
    }
}
