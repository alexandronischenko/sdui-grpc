//
//  ContentView.swift
//  sdui-test
//
//  Created by Alexandr Onischenko on 13.04.2024.
//

import SwiftUI

struct ContentView: View {

    init() {
        let env = ProcessInfo.processInfo.environment
        if env["DISABLE_ANIMATIONS"] == "1" {          // << here !!
            UIView.setAnimationsEnabled(false)
        }
    }
//    @ObservedObject private var viewModel = ViewRepository()
    @ObservedObject var viewManager: ViewManager = ViewManager()

    var body: some View {
        NavigationView {
            VStack {
                NewView(material: viewManager.material ?? ViewMaterial())
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Reset") {
                        viewManager.dataResonse = ""
                        viewManager.lastRequest = ""
                        viewManager.material = ViewMaterial()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("open todolist view") {
                        viewManager.todoListView()
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button("open static view") {
                        viewManager.staticView()
                        measureGlobal.start()
                        MeasureTimer.shared.start()
                    }
                }
            }
        }
    }

    var info: some View {
        VStack {
            HStack {
                Text(viewManager.connectivity?.description ?? "")
            }
            HStack(alignment: .center) {
                VStack{
                    Text("Request")
                        .font(.headline)
                    ScrollView {
                        Text(viewManager.lastRequest ?? "")
                    }
                }
                .padding()
                Spacer()
                VStack {
                    Text("Response")
                        .font(.headline)
                    ScrollView {
                        Text(viewManager.dataResonse ?? "")
                    }
                }
                .padding()
            }
            .frame(maxHeight: 200)
        }
    }

    var buttons: some View {
        HStack(alignment: .center, spacing: 16) {
            Button {
                viewManager.staticView()
            } label: {
                Text("Load static view")
            }.accessibilityIdentifier("staticView")
            Button {
                viewManager.listView()
            } label: {
                Text("Load list view")
            }
            Button {
                viewManager.todoListView()
            } label: {
                Text("Load todoList view")
            }
        }
        .padding()
    }
}

