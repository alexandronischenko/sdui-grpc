//
//  sdui_testUITests.swift
//  sdui-testUITests
//
//  Created by Alexandr Onischenko on 08.06.2024.
//

import XCTest
//@testable import sdui_test

final class sdui_testUITests: XCTestCase {

    var swizzledOutIdle = false

    override func setUp() {
        if swizzledOutIdle { // ensure the swizzle only happens once
            let original = class_getInstanceMethod(objc_getClass("XCUIApplicationProcess") as? AnyClass, Selector(("waitForQuiescenceIncludingAnimationsIdle:")))!
            let replaced = class_getInstanceMethod(type(of: self), #selector(replace))!
            method_exchangeImplementations(original, replaced)
            swizzledOutIdle = true
        }
        super.setUp()
    }

    @objc func replace() {
        return
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }



    func testPerformance() throws {
        let app = XCUIApplication()
        app.launchEnvironment = ["DISABLE_ANIMATIONS": "1"]
        app.launchArguments = ["testing"]
        app.launch()
//        measureGlobal.start()
//        app.buttons["open static view"].tap()
//        app.swipeUp()
//        app.swipeUp()
//        app.buttons["reset"].tap()
                //        measureGlobal.stop()
//        measureGlobal.show()
    }
}
