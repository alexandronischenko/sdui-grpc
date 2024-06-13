//
//  MonitoringServiceProtocol.swift
//  sdui-test
//
//  Created by Alexandr Onischenko on 22.04.2024.
//

import Foundation

public struct MonitoringData: Codable {
    static let invalid: MonitoringData = .init(
        fps: -1,
        cpuUsage: -1,
        ramUsage: .zero
    )

    let fps: Int
    let cpuUsage: Double
    let ramUsage: RAMInfo
}

public typealias MonitoringStatistics = [MonitoringData]

protocol MonitoringServiceProtocol {
    var isMonitoring: ObservableValue<Bool> { get }
    var isRecording: ObservableValue<Bool> { get }
    var data: ObservableValue<MonitoringData> { get }

    func startMonitoring()
    func stopMonitoring()
    func startRecoding()
    func stopRecording()

    func clearStatistics()
    func getStatistics() -> MonitoringStatistics
}

public protocol StatisticHandlerProtocol {
    func show(result: MonitoringStatistics)
}
