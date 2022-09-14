//
//  TodoBoxApp.swift
//  TodoBox WatchKit Extension
//
//  Created by Ayush Kumar on 1/8/22.
//

import SwiftUI

@main
struct TodoBoxApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
