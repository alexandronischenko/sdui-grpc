//
//  File.swift
//  
//
//  Created by Alexandr Onischenko on 14.04.2024.
//

import Foundation
import GRPC
import Vapor
import Logging

public extension Application.Servers.Provider {
    static var gRPCServer: Self {
        .init {
            $0.servers.use { app in GRPCServer(application: app)
            }
        }
    }
}

final class GRPCServer: Vapor.Server {

    var port = 5001
    var host = "192.168.1.4"
    var application: Application
    var server: GRPC.Server?


    init(application: Application) {
        self.application = application
    }

    public func start(address: BindAddress?) throws {

        switch address {
        case .none:
            break
        case .hostname(let hostname, let port):
            if let hostname = hostname {
                self.host = hostname
            }
            if let port = port {
                self.port = port
            }
        default:
            fatalError()
        }

        //set up logging
//        var logger = Logger(label: "grpc", factory: StreamLogHandler.standardOutput(label: "st"))
//        logger.logLevel = .debug

        var logger = Logger(label: "grpc")
        logger.logLevel = .debug

        //bind to host and port. do not use SSL
        let group = application.eventLoopGroup
        let server = GRPC.Server.insecure(group: group)
            .withLogger(logger)
            .withServiceProviders([ViewProvider(application)])
            .bind(host: self.host, port: self.port)
        server.map {
            $0.channel.localAddress
        }.whenSuccess { address in
            logger.debug("gRPC Server started on port \(address!.port!)", metadata: nil)
        }

        self.server = try server.wait()
    }


    public var onShutdown: EventLoopFuture<Void> {
        return server!.channel.closeFuture
    }

    public func shutdown() {
        try! self.server!.close().wait()
    }
}
