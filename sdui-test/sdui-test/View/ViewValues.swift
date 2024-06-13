//
//  Values.swift
//  sdui-test
//
//  Created by Alexandr Onischenko on 13.04.2024.
//

import Foundation

internal class ViewValues: Codable {
    var text: String?
    var imageUrl: String?
    var systemIconName: String?
    var localImageName: String?
}

extension ViewValues {
    convenience init(values: Values) {
        self.init()
        text = values.text
        imageUrl = values.imageURL
        systemIconName = values.systemIconName
        localImageName = values.localImageName
    }
}
