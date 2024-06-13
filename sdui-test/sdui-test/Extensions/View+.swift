//
//  View+.swift
//  sdui-test
//
//  Created by Alexandr Onischenko on 13.04.2024.
//

import Foundation
import SwiftUI

internal extension View {

    func embedInAnyView() -> AnyView {
        AnyView(self)
    }

}
