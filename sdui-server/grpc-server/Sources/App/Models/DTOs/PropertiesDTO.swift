//
//  File.swift
//  
//
//  Created by Alexandr Onischenko on 14.04.2024.
//

import Fluent
import Vapor

final class PropertiesDTO: Content, Model {
    static let schema = "properties"

    @ID(key: .id)
    var id: UUID?

    @OptionalField(key: "font")
    var font: String?

    @OptionalField(key: "fontWeight")
    var fontWeight: String?

    @OptionalField(key: "foregroundColor")
    var foregroundColor: String?

    @OptionalField(key: "borderColor")
    var borderColor: String?

    @OptionalField(key: "borderWidth")
    var borderWidth: Int32?

    @OptionalField(key: "padding")
    var padding: Int32?

    @OptionalField(key: "spacing")
    var spacing: Int32?

    @OptionalField(key: "width")
    var width: Float?

    @OptionalField(key: "height")
    var height: Float?

    @OptionalField(key: "minLength")
    var minLength: Float?

    @OptionalField(key: "horizontalAlignment")
    var horizontalAlignment: String?

    @OptionalField(key: "verticalAlignment")
    var verticalAlignment: String?

    @OptionalField(key: "axis")
    var axis: String?

    init() {}

    init(id: UUID? = nil, font: String? = nil, fontWeight: String? = nil, foregroundColor: String? = nil, borderColor: String? = nil, borderWidth: Int32? = nil, padding: Int32? = nil, spacing: Int32? = nil, width: Float? = nil, height: Float? = nil, minLength: Float? = nil, horizontalAlignment: String? = nil, verticalAlignment: String? = nil, axis: String? = nil) {
        self.id = id
        self.font = font
        self.fontWeight = fontWeight
        self.foregroundColor = foregroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.padding = padding
        self.spacing = spacing
        self.width = width
        self.height = height
        self.minLength = minLength
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.axis = axis
    }
}

extension PropertiesDTO {
    convenience init (_ properties: Properties) {
        self.init(id: nil,
                  font: properties.font,
                  fontWeight: properties.fontWeight,
                  foregroundColor: properties.foregroundColor,
                  borderColor: properties.borderColor,
                  borderWidth: properties.borderWidth,
                  padding: properties.padding,
                  spacing: properties.spacing,
                  width: properties.width,
                  height: properties.height,
                  minLength: properties.minLength,
                  horizontalAlignment: properties.horizontalAlignment,
                  verticalAlignment: properties.verticalAlignment,
                  axis: properties.axis)
    }
}

extension Properties {
    init(properties: PropertiesDTO) {
        self.font = properties.font ?? ""
        self.fontWeight = properties.fontWeight ?? ""
        self.foregroundColor = properties.foregroundColor ?? ""
        self.borderColor = properties.borderColor ?? ""
        self.borderWidth = properties.borderWidth ?? Int32()
        self.padding = properties.padding ?? Int32()
        self.spacing = properties.spacing ?? Int32()
        self.width = properties.width ?? Float()
        self.height = properties.height ?? Float()
        self.minLength = properties.minLength ?? Float()
        self.horizontalAlignment = properties.horizontalAlignment ?? ""
        self.verticalAlignment = properties.verticalAlignment ?? ""
        self.axis = properties.axis ?? ""
    }

    init(font: String? = nil,
         fontWeight: String? = nil,
         foregroundColor: String? = nil,
         borderColor: String? = nil,
         borderWidth: Int32? = nil,
         padding: Int32? = nil,
         spacing: Int32? = nil,
         width: Float? = nil,
         height: Float? = nil,
         minLength: Float? = nil,
         horizontalAlignment: String? = nil,
         verticalAlignment: String? = nil,
         axis: String? = nil) {
//        if font == nil { self.clearFont()} else { }
        self.font = font ?? ""
        self.fontWeight = fontWeight ?? ""
        self.foregroundColor = foregroundColor ?? ""
        self.borderColor = borderColor ?? ""
        self.borderWidth = borderWidth ?? Int32()
        self.padding = padding ?? Int32()
        self.spacing = spacing ?? Int32()
        self.width = width ?? Float()
        self.height = height ?? Float()
        self.minLength = minLength ?? Float()
        self.horizontalAlignment = horizontalAlignment ?? ""
        self.verticalAlignment = verticalAlignment ?? ""
        self.axis = axis ?? ""
    }
}
