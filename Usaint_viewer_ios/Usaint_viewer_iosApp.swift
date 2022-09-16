//
//  usaint_viewer_iosApp.swift
//  usaint_viewer_ios
//
//  Created by imseonghyeon on 2022/08/30.
//
//

import SwiftUI

@main
struct Usaint_viewer_iosApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
