//
//  FPSMeasureService.swift
//  sdui-test
//
//  Created by Alexandr Onischenko on 22.04.2024.
//

import Foundation
import FPSCounter

final class ObservableValue<T> {

    @Published var value: T

    init(_ value: T) {
        self.value = value
    }
}

protocol FPSServiceProtocol: AnyObject {
    /// negative value of fpsValue means, data is not available at this moment
    var fpsValue: ObservableValue<Int> { get }
    func startMonitoring()
    func stopMonitoring()
}

final class FPSService: NSObject, FPSServiceProtocol {

    private let fpsCounter: FPSCounter
    private var isMonitoring = false
    var fpsValue: ObservableValue<Int> = .init(0)

    override init() {
        fpsCounter = FPSCounter()
        fpsCounter.notificationDelay = 0.00001
        super.init()
        fpsCounter.delegate = self
    }

    func startMonitoring() {
        if !isMonitoring {
            fpsCounter.startTracking()
            isMonitoring = true
        }
    }

    func stopMonitoring() {
        if isMonitoring {
            fpsCounter.stopTracking()
            isMonitoring = false
        }
    }
}

extension FPSService: FPSCounterDelegate {

    func fpsCounter(_ counter: FPSCounter, didUpdateFramesPerSecond fps: Int) {
        fpsValue.value = fps
    }
}
