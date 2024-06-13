//
//  File.swift
//  
//
//  Created by Alexandr Onischenko on 14.04.2024.
//

import Foundation
import GRPC
import Vapor
import Fluent


class ViewProvider: ViewServiceProvider {
    func test(request: Empty, context: GRPC.StatusOnlyCallContext) -> NIOCore.EventLoopFuture<Empty> {
        let promise = context.eventLoop.makePromise(of: Empty.self)
        promise.succeed(Empty())
        return promise.futureResult
    }

    var interceptors: ViewServiceServerInterceptorFactoryProtocol?

    var app: Application

    init(_ app: Application) {
        print(#function)
        self.app = app
    }

    func staticView(request: Empty, context: GRPC.StatusOnlyCallContext) -> NIOCore.EventLoopFuture<gRPCView> {
        print(#function)
        var view = gRPCView()
        view.type = "ScrollView"
        view.properties.foregroundColor = "blue"

        var list = [gRPCView]()

        func text(with title: String) -> gRPCView {
            .init(type: "Text",
                  properties: .init(font: "title",
                                    borderWidth: 1),

                  values: .init(text: title))
        }

        for _ in 0..<3 {
            list.append(
                .init(type: "HStack",
                      subviews: [
                        .init(type: "Text",
                              values: .init(text: "Text")),
                        .init(type: "Spacer"),
                        .init(type: "Image",
                              values: .init(systemIconName: "checkmark"))
                      ]))
        }

        view.subviews = [
            text(with: "Text"),
            .init(type: "TextField"),
            text(with: "List"),
            .init(type: "List",
                  properties: .init(foregroundColor: "red",
                                    borderColor: "blue",
                                    borderWidth: 1,
                                    padding: 16),

                  subviews: list),

            text(with: "LazyVStack"),
            .init(type: "LazyVStack",
                  properties: .init(foregroundColor: "blue",
                                    borderColor: "gray",
                                    borderWidth: 1),
                  subviews: list),

            text(with: "LazyHStack"),
            .init(type: "LazyHStack",
                  properties: .init(foregroundColor: "green",
                                    borderColor: "blue",
                                    borderWidth: 1),
                  subviews: list),

            text(with: "VStack"),
            .init(type: "VStack",
                  properties: .init(foregroundColor: "yellow",
                                    borderColor: "blue",
                                    borderWidth: 1),
                  subviews: list),

            text(with: "HStack"),
            .init(type: "HStack",
                  properties: .init(foregroundColor: "gray",
                                    borderColor: "blue",
                                    borderWidth: 1),
                  subviews: list),

            text(with: "ZStack"),
            .init(type: "ZStack",
                  properties: .init(foregroundColor: "orange",
                                    borderColor: "blue",
                                    borderWidth: 1),
                  subviews: list),

            text(with: "Text"),
            .init(type: "Text",
                  properties: .init(foregroundColor: "blue",
                                    borderColor: "orange",
                                    borderWidth: 1),
                  subviews: list),

            text(with: "Image"),
            .init(type: "Image",
                  values: .init(systemIconName: "checkmark")),

            text(with: "Rectangle"),
            .init(type: "Rectangle",
                  properties: .init(foregroundColor: "red",
                                    borderColor: "gray",
                                    borderWidth: 1,
                                    width: 128,
                                    height: 64)),

            text(with: "Divider"),
            .init(type: "Divider"),

            text(with: "Circle"),
            .init(type: "Circle",
                  properties: .init(foregroundColor: "blue",  
                                    borderColor: "yellow",
                                    borderWidth: 1,
                                    width: 64,
                                    height: 64)),
        ]

        let promise = context.eventLoop.makePromise(of: gRPCView.self)
        promise.succeed(view)
        return promise.futureResult
    }
    
    func listView(request: Empty, context: GRPC.StatusOnlyCallContext) -> NIOCore.EventLoopFuture<gRPCView> {
        var view = gRPCView()
        view.type = "Circle"
        view.properties.foregroundColor = "black"

        let promise = context.eventLoop.makePromise(of: gRPCView.self)
        promise.succeed(view)
        return promise.futureResult
    }
    
    func toDoListView(request: Empty, context: GRPC.StatusOnlyCallContext) -> NIOCore.EventLoopFuture<gRPCView> {
        TodoModel.query(on: app.db)
            .all()
            .map { todos in
                
                var view = gRPCView()
                view.type = "List"
                var list = [gRPCView]()

                for todo in todos {
                    list.append(
                        .init(type: "HStack", 
                              subviews: [
                                .init(type: "Text",
                                      values: .init(text: todo.title)),
                                .init(type: "Text",
                                      properties: .init(font: "thin"),
                                      values: .init(text: todo.id?.uuidString ?? "")),
                                .init(type: "Spacer"),
                                .init(type: "Image",
                                      values: .init(systemIconName: todo.completed ? "checkmark" : "xmark"))
                        ]))
                }
                view.subviews = list
//                view.subviews.append(
//                    .init(type: "Text", operation: .init(type: "ActionSheet", viewName: ""))
//                )
                return view
            }
    }

    func toDoView(request: TodoID, context: GRPC.StatusOnlyCallContext) -> NIOCore.EventLoopFuture<gRPCView> {
        guard let id = UUID(uuidString: request.todoID) else {
            return context.eventLoop.makeFailedFuture(
                GRPCStatus(code: .invalidArgument, message: "Invalid TodoID"))
        }
        return TodoModel.query(on: app.db)
            .filter(\.$id == id)
            .first()
            .map { todo in
                var view = gRPCView()
                view.type = "List"
                var list = [gRPCView]()
                view.subviews = [
                    .init(type: "Text", values: .init(text: todo?.title ?? "Failed getting todomodel title"))
                ]
                return view
            }
    }

    func deleteTodo(request: TodoID, context: GRPC.StatusOnlyCallContext) -> NIOCore.EventLoopFuture<gRPCView> {
        guard let id = UUID(uuidString: request.todoID) else {
            return context.eventLoop.makeFailedFuture(
                GRPCStatus(code: .invalidArgument, message: "Invalid TodoID"))
        }
        return TodoModel.query(on: app.db)
            .filter(\.$id == id)
            .delete()
            .flatMap({ _ in
                TodoModel.query(on: self.app.db)
                    .all()
                    .map { todos in
                        var view = gRPCView()
                        view.type = "List"
                        var list = [gRPCView]()
                        for todo in todos {
                            list.append(
                                .init(type: "Text", values: .init(text: todo.title))
                            )
                        }
                        view.subviews = list
                        return view
                    }
            })
    }

    func createToDo(request: Todo, context: GRPC.StatusOnlyCallContext) -> NIOCore.EventLoopFuture<gRPCView> {
        TodoModel(id: UUID(), title: request.title, completed: request.completed).save(on: app.db)
            .flatMap({ _ in
                TodoModel.query(on: self.app.db)
                    .all()
                    .map { todos in
                        var view = gRPCView()
                        view.type = "List"
                        var list = [gRPCView]()
                        for todo in todos {
                            list.append(
                                .init(type: "Text", values: .init(text: todo.title))
                            )
                        }
                        view.subviews = list
                        return view
                    }
            })

    }
    
    func secondView(request: Empty, context: GRPC.StatusOnlyCallContext) -> NIOCore.EventLoopFuture<gRPCView> {
        var view = gRPCView()
        view.type = "ScrollView"
        view.properties.axis = "vertical"
        view.properties.verticalAlignment = "center"
        view.properties.horizontalAlignment = "center"
        view.subviews = [
            .init(type: "Text",
                          properties: .init(font: "largeTitle", horizontalAlignment: "leading"),
                  values: .init(text: "SecondView"),
                          subviews: []),
            .init(type: "HStack",
                  properties: .init(height: 48),
                          values: nil,
                          subviews: [
                            .init(type: "Image", properties: .init(padding: 16),values: .init(systemIconName: "person.circle")),
                            .init(type: "Spacer", properties: .init(horizontalAlignment: "leading")),
                            .init(type: "Text", properties: .init(font: "title",
                                                                  padding: 16,
                                                                  horizontalAlignment: "trailing"), values: .init(text: "Image"))
                          ]),
            .init(type: "HStack",
                  properties: .init(height: 48),
                  values: nil,
                  subviews: [
                    .init(type: "Image", properties: .init(padding: 16), values: .init(systemIconName: "person")),
                    .init(type: "Spacer", properties: .init(horizontalAlignment: "leading")),
                    .init(type: "Text", properties: .init(font: "title", 
                                                          padding: 16,
                                                          horizontalAlignment: "trailing"), values: .init(text: "Image"))
                  ]),
            .init(type: "HStack",
                  properties: .init(height: 48),
                  values: nil,
                  subviews: [
                    .init(type: "Image", properties: .init(padding: 16), values: .init(systemIconName: "person.fill")),
                    .init(type: "Spacer", properties: .init(horizontalAlignment: "leading")),
                    .init(type: "Text", properties: .init(font: "title", 
                                                          padding: 16,
                                                          horizontalAlignment: "trailing"), values: .init(text: "Image"))
                  ]),
        ]
//            .init(ViewDTO(type: "Image",
//                          values: .init(systemIconName: "person.circle"))),
//            .init(ViewDTO(type: "Text",
//                          properties: .init(font: "title", horizontalAlignment: "trailing"),
//                          values: .init(text: "Image"))),


        let promise = context.eventLoop.makePromise(of: gRPCView.self)
        promise.succeed(view)
        return promise.futureResult
    }
    
    func thirdView(request: Empty, context: GRPC.StatusOnlyCallContext) -> NIOCore.EventLoopFuture<gRPCView> {
        var view = gRPCView()
        view.type = "VStack"
        view.properties.foregroundColor = "black"
        view.properties.verticalAlignment = "center"
        view.properties.horizontalAlignment = "center"
        view.properties.spacing = 16
        view.subviews = [
            .init(ViewDTO(type: "Text",
                          properties: .init(font: "title", horizontalAlignment: "leading"),
                          values: .init(text: "FirstView"),
                          subviews: nil)),
            .init(ViewDTO(type: "Text",
                          properties: .init(font: "title"),
                          values: .init(text: "LARGE TITLE TEXT"),
                          subviews: nil)),
            .init(ViewDTO(type: "Text",
                          properties: .init(font: "title",
                                            fontWeight: "semibold",
                                            padding: 16),
                          values: .init(text: "Semibold Title"),
                          subviews: nil)),
            .init(ViewDTO(type: "Spacer",
                          properties: .init(),
                          values: .init(),
                          subviews: nil)),
        ]

        let promise = context.eventLoop.makePromise(of: gRPCView.self)
        promise.succeed(view)
        return promise.futureResult
    }
    
    func fourthView(request: Empty, context: GRPC.StatusOnlyCallContext) -> NIOCore.EventLoopFuture<Empty> {
        let promise = context.eventLoop.makePromise(of: Empty.self)
        promise.succeed(Empty())
        return promise.futureResult
    }
}
