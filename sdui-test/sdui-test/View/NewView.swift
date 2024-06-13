//
//  JSONDataView.swift
//  sdui-test
//
//  Created by Alexandr Onischenko on 13.04.2024.
//

import Foundation
import SwiftUI

public struct NewView: View {

    private var material: ViewMaterial?

    private var viewManager: ViewManager?

    init(viewManager: ViewManager) {
        self.viewManager = viewManager
    }

    init(material: ViewMaterial) {
        self.material = material
    }

    @ViewBuilder public func toPresentable() -> some View {
        if let material = material {
            Button {
                measureGlobal.show()
            } label: {
                Text("Show")
            }
            ViewFactory(material: material)
                .toPresentable()
                .onAppear {
                    MeasureTimer.shared.stop()
                }
        }
    }

    public var body: some View {
        toPresentable()
    }
}
