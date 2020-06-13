//
//  ApplicationState.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 19.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

enum ApplicationState {
    case unknown
    case launched
    case active
    case willResignActive
    case willEnterForeground
    case background
    case willTerminate
}
