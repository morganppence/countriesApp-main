//
//  ViewNavigationApp.swift
//  ViewNavigation
//
//  Created by jhonathan briceno on 9/20/23.
//

import SwiftUI

@main
struct ViewNavigationApp: App {
    
    let notificationManager = NotificationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didFinishLaunchingNotification)) { _ in
                    print("APP Launch")
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    print("App Did Become Active")
                    notificationManager.registerLocalNotifications()
                    UIApplication.shared.applicationIconBadgeNumber = 0
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    print("App enter Foreground")
                    UIApplication.shared.applicationIconBadgeNumber = 0
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    print("App Will Resign Active")
                    //UIApplication.shared.applicationIconBadgeNumber = 0
                }
        }
    }
}

class NotificationManager: NSObject {
    
    var didRegister = false

    func registerLocalNotifications() {
        guard !didRegister else { return }
        didRegister = true
        UNUserNotificationCenter.current().delegate = self
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        
        let body = response.notification.request.content.body
        print("jhoda body \(body)")
        print("jhoda Response \(response)")
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        print("here")
        completionHandler(.banner)
    }
    
}
