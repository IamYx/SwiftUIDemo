//
//  YXSwiftUIDemoApp.swift
//  YXSwiftUIDemo
//
//  Created by 姚肖 on 2023/4/3.
//

import SwiftUI

@main
struct YXSwiftUIDemoApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }
    }
    
}
