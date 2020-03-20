//
//  ApplicationAssembly.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 20.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Swinject
import UIKit.UIApplication

final class ApplicationAssembly { }

// MARK: - Assembly
extension ApplicationAssembly: Assembly {
    func assemble(container: Container) {
        registerAppStateEmitter(in: container)
        registerMemoryWarningEmitter(in: container)
        registerApplication(in: container)
        registerApplicationDelegate(in: container)
    }
}

// MARK: - Registrations
private extension ApplicationAssembly {
    func registerAppStateEmitter(in container: Container) {
        container.register(ApplicationStateEmitter.self) { resolver in
            let appDelegate = resolver.resolveSafe(UIApplicationDelegate.self)
            guard let appStateEmitter = appDelegate as? ApplicationStateEmitter else {
                fatalError("UIApplicationDelegate must coform to ApplicationStateEmitter")
            }
            return appStateEmitter
        }
    }
    
    func registerMemoryWarningEmitter(in container: Container) {
        container.register(MemoryWarningEmitter.self) { resolver in
            let appDelegate = resolver.resolveSafe(UIApplicationDelegate.self)
            guard let emitter = appDelegate as? MemoryWarningEmitter else {
                fatalError("UIApplicationDelegate must coform to MemoryWarningEmitter")
            }
            return emitter
        }
    }
    
    func registerApplication(in container: Container) {
        container.register(UIApplication.self) { _ in
            UIApplication.shared
        }
    }
    
    func registerApplicationDelegate(in container: Container) {
        container.register(UIApplicationDelegate.self) { resolver in
            let application = resolver.resolveSafe(UIApplication.self)
            guard let delegate = application.delegate else {
                fatalError("Can't resolve UIApplicationDelegate")
            }
            return delegate
        }
    }
}
