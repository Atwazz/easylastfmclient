//
//  AppDelegate.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UIApplication
import Combine

@UIApplicationMain
final class AppDelegate: UIResponder {
    // MARK: - Public instance properties
    var window: UIWindow?
    
    // MARK: - Private instance properties
    private let entryPointFactory = EntryPointFactory()
    private let stateSubject = CurrentValueSubject<ApplicationState, Never>(.unknown)
    private let memoryWarningSubject = PassthroughSubject<Void, Never>()
    private lazy var entryPointRouter = {
        entryPointFactory.router
    }()
}

// MARK: - ApplicationStateEmitter
extension AppDelegate: ApplicationStateEmitter {
    var state: AnyPublisher<ApplicationState, Never> {
        stateSubject.eraseToAnyPublisher()
    }
}

// MARK: -
extension AppDelegate: MemoryWarningEmitter {
    var memoryWarning: AnyPublisher<Void, Never> {
        memoryWarningSubject.eraseToAnyPublisher()
    }
}

// MARK: - UIApplicationDelegate
extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = entryPointFactory.window
        stateSubject.send(.launched)
        entryPointRouter.showInitialScreen()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        stateSubject.send(.willTerminate)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        stateSubject.send(.active)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        stateSubject.send(.willResignActive)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        stateSubject.send(.background)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        stateSubject.send(.willEnterForeground)
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        memoryWarningSubject.send(())
    }
}
