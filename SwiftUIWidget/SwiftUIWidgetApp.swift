//
//  SwiftUIWidgetApp.swift
//  SwiftUIWidget
//
//  Created by Smin Rana on 3/13/22.
//

import SwiftUI

@main
struct SwiftUIWidgetApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
