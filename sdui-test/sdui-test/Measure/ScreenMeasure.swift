//
//  ScreenMeasure.swift
//  sdui-test
//
//  Created by Alexandr Onischenko on 22.04.2024.
//

import Foundation
import QuartzCore
import UIKit

class MeasureTimer {
    static let shared = MeasureTimer()

    private init(startDate: Date? = nil, lastDate: Date? = nil) {
        self.startDate = startDate
        self.lastDate = lastDate
    }
    var startDate: Date?
    var lastDate: Date?

    func start() {
        startDate = Date.now
    }

    func stop() {
        lastDate = Date.now
        var diff = lastDate! - startDate!
        print(diff)
    }

}

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}

public let measureGlobal = ScreenMeasure.shared

public final class ScreenMeasure {

    public static let shared = ScreenMeasure()

    public var data: [CFTimeInterval] = []

    let monitoringService = MonitoringService(
        fpsService: FPSService(),
        cpuService: CPUService(),
        ramService: RAMService()
    )

    var isRecording = false
    var startTime: CFTimeInterval = 0.0

    var startDate: Date?
    var lastDate: Date?

    func start() {
        monitoringService.startMonitoring()
        startTime = CACurrentMediaTime()
        isRecording = true

        startDate = Date()
    }

    func stop() {
        guard isRecording else { return }

        let timeInterval = CACurrentMediaTime() - startTime
        data.append(timeInterval)
        isRecording = false
        monitoringService.stopRecording()

        lastDate = Date()
        var result = lastDate?.timeIntervalSince(lastDate ?? Date())
        print(result ?? "ERROR")
    }

    func show() {
//        let sumArray = data.reduce(0, +)
//
//        let avgArrayValue = sumArray / Double(data.count)
//        print("Get data and parse performance: \(avgArrayValue)")
        print(monitoringService.getAverageStatistics())
        data.removeAll()
//        print(monitoringService.getStatistics())

    }
}

extension UIViewController {

    static func swizzle() {
        let originalSelector = #selector(viewDidDisappear)
        let swizzledSelector = #selector(dc_viewDidLayoutSubviews)

        guard
            let originalMethod = class_getInstanceMethod(self, originalSelector),
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        else { return }

        method_exchangeImplementations(originalMethod, swizzledMethod)

        let originalSelector2 = #selector(viewWillAppear)
        let swizzledSelector2 = #selector(dc_viewDidSubviews)

        guard
            let originalMethod2 = class_getInstanceMethod(self, originalSelector2),
            let swizzledMethod2 = class_getInstanceMethod(self, swizzledSelector2)
        else { return }

        method_exchangeImplementations(originalMethod2, swizzledMethod2)
    }

    // MARK: - Method Swizzling

    @objc func dc_viewDidLayoutSubviews(animated: Bool) {
        self.dc_viewDidLayoutSubviews(animated: animated)

        measureGlobal.stop()
    }


    @objc func dc_viewDidSubviews(animated: Bool) {
        self.dc_viewDidSubviews(animated: animated)

        measureGlobal.start()
    }

}
