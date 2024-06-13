//
//  sdui_testTests.swift
//  sdui-testTests
//
//  Created by Alexandr Onischenko on 17.04.2024.
//

import XCTest
@testable import sdui_test

final class sdui_testTests: XCTestCase {
    var app: XCUIApplication!
    private var viewModel: ViewManager!

    override func setUpWithError() throws {
        viewModel = ViewManager()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    override func setUp() {
        continueAfterFailure = false
    }

    func testPerformanceExample() throws {
        measure {
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

            var material = ViewMaterial(view: view)
            var factory = ViewFactory(material: material)
        }
    }
}
