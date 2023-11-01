//
//  ContentViewModel.swift
//  ViewNavigation
//
//  Created by jhonathan briceno on 9/20/23.
//

import Foundation
import Combine
import UserNotifications
import UIKit

class ContentViewModel: ObservableObject {
    

    var newUpdatedName = ""
    let destinationViewModel = DestinationViewModel()
    @Published var showNotificationAlert = false
    
    private var cancellables = Set<AnyCancellable>()

    init() {
        destinationViewModel.delegate = self
        registerObservables()
    }
    
    func getNewName() -> String {
       return  NamesManager.shared.updatedName
    }
    
    func registerObservables() {
        destinationViewModel.message
            .sink { [weak self] newName in
                self?.newUpdatedName = newName
            }
            .store(in: &cancellables)
    }
    
    func scheduleNotification() {
        checkForNotificationStatus()
    }
    
    func checkForNotificationStatus() {
        
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings(completionHandler: { [weak self] permission in
            DispatchQueue.main.async {
                switch permission.authorizationStatus  {
                case .authorized:
                    print("User granted permission for notification")
                    self?.createNotification()
                case .denied:
                    print("User denied notification permission")
                    self?.showNotificationAlert = true
                case .notDetermined:
                    print("Notification permission haven't been asked yet")
                    self?.getNotificationPermissions()
                default:
                    break
                }
            }

        })
    }
                                        
    func getNotificationPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { [weak self] success, error in
            DispatchQueue.main.async {
                if success {
                    self?.createNotification()
                } else if let error = error {
                    print(error.localizedDescription)
                } else {
                    self?.showNotificationAlert = true
                }
            }
        }
    }
    
    func createNotification() {
        UIApplication.shared.applicationIconBadgeNumber += 1

        let content = UNMutableNotificationContent()
        content.title = "Check the APP"
        content.subtitle = "time to learn about countries"
        content.sound = UNNotificationSound.default
        content.badge = UIApplication.shared.applicationIconBadgeNumber as NSNumber
        content.body = "something here"

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
    
}

extension ContentViewModel: DestinationViewProtocol {
    
    func updateName(name: String) {
//        newUpdatedName = name
    }
}
