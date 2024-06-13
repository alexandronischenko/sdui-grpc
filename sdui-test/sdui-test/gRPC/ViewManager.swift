//
//  ViewAscyncProvider.swift
//  sdui-test
//
//  Created by Alexandr Onischenko on 22.04.2024.
//

import Foundation
import GRPC
import SwiftProtobuf
import NIO

//enum ViewManagerStatus: String {
//    case initial = "initializing"
//    case calling = "calling"
//    case connected = "connected"
//    case failed = "failed"
//    case lost = "lost"
//    case none = "none"
//}

@MainActor
class ViewManager: ObservableObject {
    private let group: EventLoopGroup
    private let client: ViewServiceNIOClient
    private let empty: Empty

    @Published var material: ViewMaterial?
    @Published var lastRequest: String?
    @Published var dataResonse: String?
    @Published var connectivity: String?

    init() {
        group = MultiThreadedEventLoopGroup(numberOfThreads: 2)
        let connection = ClientConnection.insecure (group: group)
            .connect(host: "192.168.1.4", port: 5001)
        client = ViewServiceNIOClient(channel: connection)
        empty = Empty()
        connectivity = "\(connection.connectivity.state)"
    }

    func staticView() {

        let call = client.staticView(empty)

        connectivity = "\(call.status)"

        call.response.whenComplete { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.material = ViewMaterial(view: success)
                    self.material?.manager = self
                    self.lastRequest = call.path
                    self.dataResonse = success.debugDescription
                }
                self.connectivity = "\(call.status)"
            case .failure(let failure):
                self.dataResonse = failure.localizedDescription
                print("error \(failure)")

            }
        }
    }

    func listView() {
        let call = client.listView(empty)
        lastRequest = call.path
        do {
            try call.response.flatMapThrowing({ view in
                DispatchQueue.main.async {
                    self.material = ViewMaterial(view: view)
                    self.material?.manager = self
                    self.lastRequest = call.path
                    self.dataResonse = view.debugDescription
                }
                print("view \(view)")
            })
        } catch let error {
            print("error \(error)")
        }
    }

    func todoListView() {
        print(#function)
        let call = client.toDoListView(empty)

        do {
            let response = try call.response.flatMapThrowing({ view in
                DispatchQueue.main.async {
                    self.material = ViewMaterial(view: view)
                    self.material?.manager = self
                    self.lastRequest = call.path
                    self.dataResonse = view.debugDescription
                }
                print(view)
            })

            print(response)
        } catch let error {
            print("error \(error)")
        }
    }

    func todoView(id: String) {
        print(#function)
        let call = client.toDoView(TodoID(id: id))
        lastRequest = call.path
        do {
            let response = try call.response.flatMapThrowing({ view in
                DispatchQueue.main.async {
                    self.material = ViewMaterial(view: view)
                    self.material?.manager = self

                }
                print(view)
            })


            print(response)
        } catch let error {
            print("error \(error)")
        }
    }

    func createTodo(title: String, completed: Bool) {
        print(#function)
        let call = client.createToDo(Todo(title: title, isCompleted: completed))
        lastRequest = call.path
        do {
            let response = try call.response.flatMapThrowing({ view in
                DispatchQueue.main.async {
                    self.material = ViewMaterial(view: view)
                    self.material?.manager = self

                }
                print(view)
            })


            print(response)
        } catch let error {
            print("error \(error)")
        }
    }

    func deleteTodo(id: String) {
        print(#function)
        let call = client.deleteTodo(TodoID(id: id))
        lastRequest = call.path
        do {
            let response = try call.response.flatMapThrowing({ view in
                DispatchQueue.main.async {
                    self.material = ViewMaterial(view: view)
                    self.material?.manager = self
                }
                print(view)
            })

            print(response)

        } catch let error {
            print("error \(error)")
        }
    }

    //    func updateView() {
    //        switch lastCall {
    //        case "/ViewService/StaticView":
    //            staticView()
    //        case "/ViewService/ListView":
    //            listView()
    //        case "/ViewService/TodoListView":
    //            todoListView()
    //        default:
    //            break
    //        }
    //        self.lastRequest = lastCall
    //    }

    deinit {
        try? group.syncShutdownGracefully()
    }
}
