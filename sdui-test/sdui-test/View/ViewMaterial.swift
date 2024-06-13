//
//  ViewMaterial.swift
//  sdui-test
//
//  Created by Alexandr Onischenko on 13.04.2024.
//

import Foundation

class ViewMaterial: Codable, Identifiable {
    var id = UUID()
    var type: ViewType?
    var values: ViewValues?
    var properties: ViewProperties?
    var subviews: [ViewMaterial]?
    var operation: ViewOperation?

    var manager: ViewManager?

    enum CodingKeys: String, CodingKey {
        case type
        case values
        case properties
        case subviews
    }
}

extension ViewMaterial {
    convenience init(view: gRPCView) {
        self.init()
        self.type = ViewType(rawValue: view.type)
        self.properties = ViewProperties(prop: view.properties)
        self.values = ViewValues(values: view.values)
        self.subviews = view.subviews.map({ subview in
            ViewMaterial(view: subview)
        })
        self.operation = ViewOperation(operation: view.operation)
    }
}
