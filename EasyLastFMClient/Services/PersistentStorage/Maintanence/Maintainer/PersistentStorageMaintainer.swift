//
//  PersistentStorageMaintainer.swift
//  Easy Last FM Client
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
    private let viewContextProvider: PSViewContextProvider
    private let storageStateSubject = CurrentValueSubject<PersistentStorageState, Never>(.unknown)
    private var disposeBag = DisposeBag()
    
    // MARK: - Init
    init(appStateEmitter: ApplicationStateEmitter,
         storageLoader: PersistentStorageLoader,
         viewContextProvider: PSViewContextProvider) {
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
            viewContextProvider.viewContext.saveIfNeeded()
        default:
            fatalError("Unexpected application state: \(state)")
        }
    }
    
    func loadPersistentStorage() {
        storageLoader.load { [weak self] result in
            switch result {
            case .success:
                self?.storageStateSubject.send(.loaded)
            case .failure(let error):
                assertionFailure("Persistent storage loading failed: \(error)")
                self?.storageStateSubject.send(.loadFailed(error: error))
            }
        }
    }
}
