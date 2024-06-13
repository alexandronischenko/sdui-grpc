//
//  ViewType.swift
//  sdui-test
//
//  Created by Alexandr Onischenko on 13.04.2024.
//

import Foundation

internal enum ViewType: String, Codable {
    case Image          = "Image"
    case Text           = "Text"
    case LazyHStack     = "LazyHStack"
    case LazyVStack     = "LazyVStack"
    case HStack         = "HStack"
    case VStack         = "VStack"
    case ZStack         = "ZStack"
    case Rectangle      = "Rectangle"
    case Circle         = "Circle"
    case Spacer         = "Spacer"
    case Divider        = "Divider"
    case List           = "List"
    case ScrollView     = "ScrollView"

    case TextField     = "TextField"
}
