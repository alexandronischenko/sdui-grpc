//
//  PresentableProtocol.swift
//  sdui-test
//
//  Created by Alexandr Onischenko on 13.04.2024.
//

import Foundation
import SwiftUI

internal protocol PresentableProtocol {
    associatedtype Content: View

    func toPresentable() -> Content
}
