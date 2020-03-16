//
//  ArtistsSearchPresenter.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation
import Combine

final class ArtistsSearchPresenter {
    // MARK: - Private static properties
    private static let pageSize: UInt = 50
    
    // MARK: - Public instance properties
    @DelayedImmutable var view: ArtistsSearchViewInput
    @DelayedImmutable var interactor: ArtistsSearchInteractorInput
    @DelayedImmutable var router: ArtistsSearchRouterInput
    
    // MARK: - Private instance properties
    private var disposeBag = DisposeBag()
    private let searchTrigger = PassthroughSubject<String, Never>()
}

// MARK: - ArtistsSearchViewOutput
extension ArtistsSearchPresenter: ArtistsSearchViewOutput {
    func viewWillAppear() {
        subscribeToSearchTrigger()
    }
    
    func viewDidDisappear() {
        disposeBag.dispose()
    }
    
    func triggerSearch(_ searchText: String?) {
        guard let searchText = searchText,
            searchText.count > 0 else {
                view.cleanSearchResults()
                return
        }
        searchTrigger.send(searchText)
    }
}

// MARK: - ArtistsSearchInteractorOutput
extension ArtistsSearchPresenter: ArtistsSearchInteractorOutput {
    
}

// MARK: - ArtistsSearchRouterOutput
extension ArtistsSearchPresenter: ArtistsSearchRouterOutput {
    
}

// MARK: - Private
private extension ArtistsSearchPresenter {
    func subscribeToSearchTrigger() {
        searchTrigger
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .filter { $0.count > 2 }
            .sink { [weak self] searchText in
                self?.interactor.triggerSearch(searchText,
                                               page: 1,
                                               pageSize: Self.pageSize)
            }
            .store(in: &disposeBag)
    }
}
