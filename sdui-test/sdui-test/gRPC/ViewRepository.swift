//
//  ClientProvider.swift
//  sdui-test
//
//  Created by Alexandr Onischenko on 15.04.2024.
//

import Foundation
import GRPC
import SwiftProtobuf
import NIO
import Combine

class ViewRepository: ObservableObject {
    private let group: EventLoopGroup
    private let client: ViewServiceClientProtocol
    private var disposeBag = Set<AnyCancellable>()
    
    @Published var material: ViewMaterial?
    @Published var lastRequest: String?
    @Published var dataResonse: String?

    var view: gRPCView = gRPCView()

    init() {
        group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let connection = ClientConnection.insecure (group: group)
            .connect(host: "localhost", port: 1234)
        client = ViewServiceNIOClient(channel: connection)
    }

    deinit {
        try? group.syncShutdownGracefully()
    }
    


//    func openScreen(name: String) {
//        if var pick = pick[name] {
//            pick()
//        }
//    }

//    func firstView() {
////        var start = DispatchTime.now().uptimeNanoseconds
//        let call = client.firstView(Empty(), callOptions: nil)
//        self.lastRequest = call.path
//
//        Future<gRPCView, Never> { [weak self] completion in
//            do {
//                let response = try call.response.wait()
//                self?.dataResonse = response.textFormatString()
//                completion(.success(response))
////                var finish = DispatchTime.now().uptimeNaxnoseconds
////                print(finish - start)
//            } catch {
//                print(error)
//            }
//        }
//        .subscribe(on: DispatchQueue.global(qos: .userInitiated))
//        .receive(on: DispatchQueue.main)
//        .map { ViewMaterial(view: $0) }
//        .assign(to: \.material, on: self)
//        .store(in: &self.disposeBag)
//    }
//
//    func secondView() {
//        let call = client.secondView(Empty(), callOptions: nil)
//        self.lastRequest = call.path
//        Future<gRPCView, Never> { [weak self] completion in
//            do {
//                let response = try call.response.wait()
//                self?.dataResonse = response.textFormatString()
//                completion(.success(response))
//            } catch {
//                print(error)
//            }
//        }
//        .subscribe(on: DispatchQueue.global(qos: .userInitiated))
//        .receive(on: DispatchQueue.main)
//        .map { ViewMaterial(view: $0) }
//        .assign(to: \.material, on: self)
//        .store(in: &self.disposeBag)
//    }
//
//    func thirdView() {
//        let call = client.thirdView(Empty(), callOptions: nil)
//        self.lastRequest = call.path
//        Future<gRPCView, Never> { [weak self] completion in
//            do {
//                let response = try call.response.wait()
//                self?.dataResonse = response.textFormatString()
//                completion(.success(response))
//            } catch {
//                print(error)
//            }
//        }
//        .subscribe(on: DispatchQueue.global(qos: .userInitiated))
//        .receive(on: DispatchQueue.main)
//        .map { ViewMaterial(view: $0) }
//        .assign(to: \.material, on: self)
//        .store(in: &self.disposeBag)
//    }
}

extension ViewRepository {
//    var pick: [String : () -> Void] = {
//        [
//        "newScreen"     : {
//            firstView()
//        },
//        ]
//    }()



}
