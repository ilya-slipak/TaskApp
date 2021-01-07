//
//  AppDelegate.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 07.01.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let theme = Theme()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        theme.setup()
        let taskListController = ScreenFactory.makeTaskListScreen()
        let navigationController = UINavigationController(rootViewController: taskListController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}
