//
//  File.swift
//  
//
//  Created by Alexandr Onischenko on 14.04.2024.
//

import Vapor
import Fluent

final class ValuesDTO: Content, Model {
    static var schema = "values"

    @ID(key: .id)
    var id: UUID?

    @OptionalField(key: "text")
    var text: String?

    @OptionalField(key: "imageURL")
    var imageURL: String?

    @OptionalField(key: "systemIconName")
    var systemIconName: String?

    @OptionalField(key: "localImageName")
    var localImageName: String?

    init() { }

    init(id: UUID? = nil, text: String? = nil, imageURL: String? = nil, systemIconName: String? = nil, localImageName: String? = nil) {
        self.id = id
        self.text = text
        self.imageURL = imageURL
        self.systemIconName = systemIconName
        self.localImageName = localImageName
    }
}

extension ValuesDTO {
    convenience init (_ values: Values) {
        self.init(id: nil, text: values.text, imageURL: values.imageURL, systemIconName: values.systemIconName, localImageName: values.localImageName)
    }
}

extension Values {
    init (_ view: ValuesDTO) {
        self.imageURL = view.imageURL ?? ""
        self.localImageName = view.localImageName ?? ""
        self.systemIconName = view.systemIconName ?? ""
        self.text = view.text ?? ""
    }

    init (imageURL: String = "",
          localImageName: String = "",
          systemIconName: String = "",
          text: String = "")
    {
        self.imageURL = imageURL
        self.localImageName = localImageName
        self.systemIconName = systemIconName
        self.text = text
    }
}
