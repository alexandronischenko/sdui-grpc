//
//  ViewOperation.swift
//  sdui-test
//
//  Created by Alexandr Onischenko on 24.04.2024.
//

import Foundation

internal class ViewOperation: Codable {
    var type: ActionType?
    var viewName: String?
    var universalLink: String?
}

extension ViewOperation {
    convenience init(operation: Operation) {
        self.init()
        self.type = ActionType(rawValue: operation.type)
        self.viewName = operation.viewName
        self.universalLink = operation.universalLink
    }
}

internal enum ActionType: String, Codable {
    case none           = "none"
    case newScreen      = "newScreen"
    case back           = "back"
    case universalLink  = "universalLink"
    case updateScreen   = "updateScreen"
}
