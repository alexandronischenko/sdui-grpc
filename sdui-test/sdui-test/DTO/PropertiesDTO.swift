//
//  File.swift
//  
//
//  Created by Alexandr Onischenko on 14.04.2024.
//


final class PropertiesDTO {

    var id: String?
    var font: String?
    var fontWeight: String?
    var foregroundColor: String?
    var borderColor: String?
    var borderWidth: Int32?
    var padding: Int32?
    var spacing: Int32?
    var width: Float?
    var height: Float?
    var minLength: Float?
    var horizontalAlignment: String?
    var verticalAlignment: String?
    var axis: String?

    init() {}

    init(id: String? = nil, font: String? = nil, fontWeight: String? = nil, foregroundColor: String? = nil, borderColor: String? = nil, borderWidth: Int32? = nil, padding: Int32? = nil, spacing: Int32? = nil, width: Float? = nil, height: Float? = nil, minLength: Float? = nil, horizontalAlignment: String? = nil, verticalAlignment: String? = nil, axis: String? = nil) {
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
