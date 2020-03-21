//
//  Result+Convenience.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

extension Result where Success == Void {
    static var success: Result {
        .success(())
    }
}
