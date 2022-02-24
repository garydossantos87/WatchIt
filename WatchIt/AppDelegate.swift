//
//  AppDelegate.swift
//  WatchIt
//
//  Created by Gary Dos Santos de Andrade on 23/2/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let context = HomeViewModel.Context(getTrendings: Home.UseCase.getTrendings())
        let viewModel = HomeViewModel(context: context)
        let homeViewController = Home.ViewController(viewModel: viewModel)
        let navController = UINavigationController(rootViewController: homeViewController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }


}

