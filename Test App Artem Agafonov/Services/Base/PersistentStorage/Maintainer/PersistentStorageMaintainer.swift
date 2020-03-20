//
//  PersistentStorageMaintainer.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 20.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import CoreData.NSPersistentContainer
import Combine

final class PersistentStorageMaintainer {
    // MARK: - Private instance properties
    private let appStateEmitter: ApplicationStateEmitter
    private let storageLoader: PersistentStorageLoader
    private let viewContextProvider: ViewContextProvider
    private let storageStateSubject = CurrentValueSubject<PersistentStorageState, Never>(.unknown)
    private var disposeBag = DisposeBag()
    
    // MARK: - Init
    init(appStateEmitter: ApplicationStateEmitter,
         storageLoader: PersistentStorageLoader,
         viewContextProvider: ViewContextProvider) {
        self.appStateEmitter = appStateEmitter
        self.storageLoader = storageLoader
        self.viewContextProvider = viewContextProvider
        subscribeToApplicationState()
    }
}

// MARK: - PersistentStorageStateEmitter
extension PersistentStorageMaintainer: PersistentStorageStateEmitter {
    var state: AnyPublisher<PersistentStorageState, Never> {
        storageStateSubject.eraseToAnyPublisher()
    }
}

// MARK: - Private
private extension PersistentStorageMaintainer {
    func subscribeToApplicationState() {
        appStateEmitter.state
            .filter { $0 == .launched || $0 == .willTerminate }
            .sink { [weak self] state in
                self?.handle(applicationState: state)
            }
            .store(in: &disposeBag)
    }
    
    func handle(applicationState: ApplicationState) {
        switch applicationState {
        case .launched:
            loadPersistentStorage()
        case .willTerminate:
            saveViewContext()
        default:
            fatalError("Unexpected application state: \(state)")
        }
    }
    
    func loadPersistentStorage() {
        storageLoader.load { [weak self] result in
            switch result {
            case .success(_):
                self?.storageStateSubject.send(.loaded)
            case .failure(let error):
                assertionFailure("Persistent storage loading failed: \(error)")
                self?.storageStateSubject.send(.loadFailed(error: error))
            }
        }
    }
    
    func saveViewContext() {
        let context = viewContextProvider.viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
