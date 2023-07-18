//
//  StringHelper.swift
//  news-app
//
//  Created by huseyin on 18.07.2023.
//

import Foundation

class StringHelper {
    static let shared = StringHelper()

    private init() {}

    func removeStringAfterDash (_ inputString: String) -> String {
        let components = inputString.components(separatedBy: "-")
        let result = components.dropLast().joined(separator: "-")
        return result
    }
}
