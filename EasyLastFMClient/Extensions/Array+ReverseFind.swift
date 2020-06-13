//
//  Array+ReverseFind.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

extension Array {
    func reverseFind(_ block: (Element) -> Bool) -> Element? {
        for element in reversed() {
            if block(element) {
                return element
            }
        }
        return nil
    }
}
