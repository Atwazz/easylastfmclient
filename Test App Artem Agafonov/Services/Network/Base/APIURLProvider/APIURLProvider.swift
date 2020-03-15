//
//  APIURLProvider.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 15.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSURL

protocol APIURLProvider {
    var apiURL: URL { get }
}
