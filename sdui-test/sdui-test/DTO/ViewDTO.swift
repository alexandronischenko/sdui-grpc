//
//  File.swift
//  
//
//  Created by Alexandr Onischenko on 14.04.2024.
//

final class ViewDTO {

    var id: String?
    var type: String

    var properties: PropertiesDTO?

    var values: ValuesDTO?

    var subviews: [ViewDTO]?

//    init() {}

    init(id: String? = nil, type: String, properties: PropertiesDTO? = nil, values: ValuesDTO? = nil, subviews: [ViewDTO]? = nil) {
        self.id = id
        self.type = type
        self.properties = properties
        self.values = values
        self.subviews = subviews
    }
}

extension ViewDTO {
    convenience init (_ view: gRPCView) {
        self.init(id: nil, 
                  type: view.type,
                  properties:
                    PropertiesDTO(view.properties),
                  values: ValuesDTO(view.values),
                  subviews: view.subviews.map({ subview in
            ViewDTO(subview)
        }))
    }
}

extension gRPCView {
    init (_ view: ViewDTO) {
        self.type = view.type
        self.properties = Properties(properties: view.properties ?? PropertiesDTO())
        self.values = Values(view.values ?? ValuesDTO())
        self.subviews = view.subviews?.map({ subview in
            gRPCView(subview)
        }) ?? []
    }

    init(type: String, properties: Properties? = Properties(), values: Values? = Values(), subviews: [gRPCView] = [], operation: Operation? = Operation()) {
        self.type = type
        self.properties = properties ?? Properties()
        self.values = values ?? Values()
        self.subviews = subviews 
        self.operation = operation ?? Operation()
    }
}

extension Operation {
    init(type: String = "", viewName: String = "", universalLink: String = "") {
//        if type == nil { }
        self.type = type
        self.viewName = viewName
        self.universalLink = universalLink
    }
}
