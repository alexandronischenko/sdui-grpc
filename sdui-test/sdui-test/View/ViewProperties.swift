//
//  ViewProperties.swift
//  sdui-test
//
//  Created by Alexandr Onischenko on 13.04.2024.
//

import Foundation
import SwiftUI

internal class ViewProperties: Codable {
    var font: String? = "body"
    var fontWeight: String? = "body"
    var foregroundColor: String? = "#ffffff" // Hex
    var borderColor: String? = "#ff0000"// Hex
    var borderWidth: Int? = 0
    var padding: Int? = 0
    var spacing: Int? = 0
    var width: Float?
    var height: Float?
    var minLength: Float? // Spacer

    /// leading, center, trailing
    var horizontalAlignment: String?

    /// top, bottom, center, firstTextBaseline, lastTextBaseline
    var verticalAlignment: String?

    /// vertical, horizontal (for ScrollView)
    var axis: String?
    var showsIndicators: Bool?
}

extension ViewProperties {
    convenience init(prop: Properties) {
        self.init()
        self.font = prop.hasFont ? prop.font : nil
        self.fontWeight = prop.hasFontWeight ? prop.fontWeight : nil
        self.foregroundColor = prop.hasForegroundColor ? prop.foregroundColor : nil
        self.borderColor = prop.hasBorderColor ? prop.borderColor : nil
        self.borderWidth = prop.hasBorderWidth ? Int(prop.borderWidth) : nil
        self.padding = prop.hasPadding ? Int(prop.padding) : nil
        self.spacing = prop.hasSpacing ? Int(prop.spacing) : nil
        self.width = prop.hasWidth ? prop.width : nil
        self.height = prop.hasHeight ? prop.height : nil
        self.minLength = prop.hasMinLength ? prop.minLength : nil
        self.horizontalAlignment = prop.hasHorizontalAlignment ? prop.horizontalAlignment : nil
        self.verticalAlignment = prop.hasVerticalAlignment ? prop.verticalAlignment : nil
        self.axis = prop.hasAxis ? prop.axis : nil
        self.showsIndicators = prop.hasShowsIndicators ? prop.showsIndicators : nil
    }
}

// ScrollView
extension SwiftUI.Axis.Set {
    static let pick: [String : SwiftUI.Axis.Set] = [
        "vertical"   : .vertical,
        "horizontal" : .horizontal
    ]
}

// VStack
extension SwiftUI.HorizontalAlignment {
    static let pick: [String : SwiftUI.HorizontalAlignment] = [
        "leading"  : .leading,
        "center"   : .center,
        "trailing" : .trailing
    ]
}

// HStack
extension SwiftUI.VerticalAlignment {
    static let pick: [String : SwiftUI.VerticalAlignment] = [
        "top"               : .top,
        "center"            : .center,
        "bottom"            : .bottom,
        "firstTextBaseline" : .firstTextBaseline,
        "lastTextBaseline"  : .lastTextBaseline
    ]
}

// Font
extension SwiftUI.Font {
    static let pick: [String : Font] = [
        "largeTitle"  : .largeTitle,
        "title"       : .title,
        "headline"    : .headline,
        "subheadline" : .subheadline,
        "body"        : .body,
        "callout"     : .callout,
        "footnote"    : .footnote,
        "caption"     : .caption
    ]
}

// FontWeight
extension SwiftUI.Font.Weight {
    static let pick: [String : Font.Weight] = [
        "ultraLight" : .ultraLight,
        "thin"       : .thin,
        "light"      : .light,
        "regular"    : .regular,
        "medium"     : .medium,
        "semibold"   : .semibold,
        "bold"       : .bold,
        "heavy"      : .heavy,
        "black"      : .black
    ]
}

extension SwiftUI.Color {
    static let pick: [String : Color] = [
        "black"     : .black,
        "white"     : .white,
        "red"       : .red,
        "blue"      : .blue,
        "green"     : .green,
        "yellow"    : .yellow,
        "gray"      : .gray,
        "orange"    : .orange,
    ]
}



extension Optional where Wrapped == Int {
    func toCGFloat() -> CGFloat? {
        guard let nonNil = self else { return nil }
        return CGFloat(nonNil)
    }
}

extension Optional where Wrapped == Float {
    func toCGFloat() -> CGFloat? {
        guard let nonNil = self else { return nil }
        return CGFloat(nonNil)
    }
}

extension Optional where Wrapped == String {
    func toColor() -> Color? {
        guard let nonNil = self else { return nil }
        return Color(nonNil, bundle: .main)
    }
}
