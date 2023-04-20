//
//  DebugHandler.swift
//  
//
//  Created by Taylor Lineman on 4/20/23.
//

import Foundation
import SwiftUI

class DebugHandler: ObservableObject {
    enum DebugTab: Identifiable, Equatable {
        public var id: String { title }
        
        case console
        case mirror(id: String, mirror: Mirror)
        case customView(id: String, view: AnyView)
        
        var title: String {
            switch self {
            case .console:
                return "Console"
            case .mirror(let id, _):
                return id
            case .customView(let id, _):
                return id
            }
        }
        
        static func == (lhs: DebugHandler.DebugTab, rhs: DebugHandler.DebugTab) -> Bool {
            return lhs.id == rhs.id
        }
    }
    
    @Published var debugTabs: [DebugTab] = [.console]
    @Published var currentTabIndex: Int = 0
    
    public static let shared = DebugHandler()
    
    private init() { }
    
    func registerCustomDebugView(id: String, view: AnyView) {
        debugTabs.removeAll { tab in
            switch tab {
            case .customView(let tabID, _):
                return tabID == id
            default:
                return false
            }
        }
        
        debugTabs.append(.customView(id: id, view: view))
    }
    
    func registerMirror(id: String, mirror: Mirror) {
        debugTabs.removeAll { tab in
            switch tab {
            case .mirror(let tabID, _):
                return tabID == id
            default:
                return false
            }
        }
        
        debugTabs.append(.mirror(id: id, mirror: mirror))
    }
    
    func hasPreviousTab() -> Bool {
        return currentTabIndex != 0
    }
    
    func previousTab() {
        if currentTabIndex != 0 {
            currentTabIndex -= 1
        }
    }
    
    func hasNextTab() -> Bool {
        return currentTabIndex != debugTabs.count - 1
    }
    
    func nextTab() {
        if currentTabIndex != debugTabs.count - 1  {
            currentTabIndex += 1
        }
    }
}
