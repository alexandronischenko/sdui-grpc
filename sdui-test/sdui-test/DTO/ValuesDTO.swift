//
//  File.swift
//  
//
//  Created by Alexandr Onischenko on 14.04.2024.
//


final class ValuesDTO {

    var id: String?

    var text: String?

    var imageURL: String?

    var systemIconName: String?

    var localImageName: String?

    init() { }

    init(id: String? = nil, text: String? = nil, imageURL: String? = nil, systemIconName: String? = nil, localImageName: String? = nil) {
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
