//
//  Measure.swift
//  sdui-test
//
//  Created by Alexandr Onischenko on 22.04.2024.
//

import SwiftUI

struct Measure<Content: View>: View {
    @State var cost: TimeInterval = 0
    var content: Content

    init(@ViewBuilder builder: () -> Content) {
        // discard first time
        content = builder()

        let start = Date()
        let count = 50
        for _ in 0..<count {
            content = builder()
        }
        self._cost = State(initialValue: Date().timeIntervalSince(start) / Double(count))
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            self.content
            Text("\(Int(self.cost * 1000_1000))μs")
                .font(.system(.caption, design: .monospaced))
                .padding(.vertical, 3)
                .padding(.horizontal, 5)
                .background(Color.orange)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 3))
        }
    }
}

struct Measure_Previews: PreviewProvider {
    static var previews: some View {
        Measure {
            Text("Hello World")
        }
    }
}
