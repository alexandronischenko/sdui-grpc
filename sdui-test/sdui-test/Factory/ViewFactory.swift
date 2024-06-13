//
//  ViewFactory.swift
//  sdui-test
//
//  Created by Alexandr Onischenko on 13.04.2024.
//

import Foundation
import SwiftUI
import Combine
import JavaScriptCore

internal struct ViewFactory: PresentableProtocol {
    @Environment(\.presentationMode) var presentationMode
    private let material: ViewMaterial
    private weak var viewManager: ViewManager?

    @ObservedObject var textValidator = TextValidator()


    init(material: ViewMaterial) {
        self.material = material
    }

    // MARK: - ScrollView
    @ViewBuilder func scrollView() -> some View {
        if let subviews = material.subviews {

            let axisKey = material.properties?.axis ?? "vertical"
            let axis = Axis.Set.pick[axisKey] ?? .vertical
            let showsIndicators = material.properties?.showsIndicators ?? true

            ScrollView(axis, showsIndicators: showsIndicators) {
                AxisBasedStack(axis: axis) {
                    ForEach(subviews) { (subview) in
                        ViewFactory(material: subview).toPresentable()
                    }
                }
            }
        } else {
            Text("Please Add Subview for" + #function)
        }
    }

    // MARK: - List
    @ViewBuilder func list() -> some View {
        if let subviews = material.subviews {
            List(subviews) {
                ViewFactory(material: $0).toPresentable()
                    .swipeActions {
                        Button {
                            viewManager?.deleteTodo(id: "0")
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
            }
        } else {
            Text("Please Add Subview for List")
        }
    }

    // MARK: - VStack
    @ViewBuilder func vstack() -> some View {
        if let subviews = material.subviews {
            let spacing = material.properties?.spacing.toCGFloat() ?? 16
            let horizontalAlignmentKey = material.properties?.horizontalAlignment ?? "center"
            let horizontalAlignment = HorizontalAlignment.pick[horizontalAlignmentKey] ?? .center
            VStack(alignment: horizontalAlignment, spacing: spacing) {
                ForEach(subviews) {
                    ViewFactory(material: $0).toPresentable()
                }
            }
        } else {
            Text("Please Add Subview for VStack")
        }
    }

    // MARK: - LazyVStack
    @ViewBuilder func lazyVstack() -> some View {
        if let subviews = material.subviews {
            let spacing = material.properties?.spacing.toCGFloat() ?? 0
            let horizontalAlignmentKey = material.properties?.horizontalAlignment ?? "center"
            let horizontalAlignment = HorizontalAlignment.pick[horizontalAlignmentKey] ?? .center
            LazyVStack(alignment: horizontalAlignment, spacing: spacing) {
                ForEach(subviews) {
                    ViewFactory(material: $0).toPresentable()
                }
            }
        } else {
            Text("Please Add Subview for LazyVStack")
        }
    }

    // MARK: - HStack
    @ViewBuilder func hstack() -> some View {
        if let subviews = material.subviews {
            let spacing = material.properties?.spacing.toCGFloat() ?? 0
            let verticalAlignmentKey = material.properties?.verticalAlignment ?? "center"
            let verticalAlignment = VerticalAlignment.pick[verticalAlignmentKey] ?? .center
            HStack(alignment: verticalAlignment, spacing: spacing) {
                ForEach(subviews) {
                    ViewFactory(material: $0).toPresentable()
                }
            }
        } else {
            Text("Please Add Subview for LazyHStack")
        }
    }

    // MARK: - HStack
    @ViewBuilder func lazyHstack() -> some View {
        if let subviews = material.subviews {
            let spacing = material.properties?.spacing.toCGFloat() ?? 0
            let verticalAlignmentKey = material.properties?.verticalAlignment ?? "center"
            let verticalAlignment = VerticalAlignment.pick[verticalAlignmentKey] ?? .center
            LazyHStack(alignment: verticalAlignment, spacing: spacing) {
                ForEach(subviews) {
                    ViewFactory(material: $0).toPresentable()
                }
            }
        } else {
            Text("Please Add Subview for HStack")
        }
    }

    // MARK: - ZStack
    @ViewBuilder func zstack() -> some View {
        if let subviews = material.subviews {
            ZStack {
                ForEach(subviews) {
                    ViewFactory(material: $0).toPresentable()
                }
            }
        } else {
            Text("Please Add Subview for ZStack")
        }
    }

    // MARK: - Text
    @ViewBuilder func text() -> some View {
        let fontHashValue = material.properties?.font ?? "body"
        let font = Font.pick[fontHashValue]
        let fontWeightHashValue = material.properties?.fontWeight ?? "regular"
        let fontWeight = Font.Weight.pick[fontWeightHashValue]
        Text(material.values?.text ?? "")
            .font(font)
            .fontWeight(fontWeight)
            .accessibilityLabel("Text")
    }

    // MARK: - Image
    @ViewBuilder func image() -> some View {
        if let systemIconName = material.values?.systemIconName {
            Image(systemName: systemIconName)
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
        } else if let localIconName = material.values?.localImageName {
            Image(localIconName)
                .resizable()
                .scaledToFit()

        } else if let remoteUrl = material.values?.imageUrl {
//            URLSession.shared.dataTask(with: remoteUrl) { data, response, error in
//                if let error = error {
//                    print("Error: \(error.localizedDescription)")
//                    return
//                }
//                guard let data = data, let image = UIImage(data: data) else {
//                    print("Invalid data or image")
//                    return
//                }
//                Image(uiImage: image)
//            }.resume()
//            KFImage(URL(string: remoteUrl))
//                .resizable()
//                .scaledToFit()
            // MARK: - ADD IMAGE FROM URL LOADING
        } else {
            Text("Image value could not read")
        }
    }

    // MARK: - Image
    @ViewBuilder func textField() -> some View {
        TextField("Type Here", text: $textValidator.text)
            .onReceive(textValidator.$text) { newValue in
                let context = JSContext()!

                context.evaluateScript(#"""
                function phoneNumberMask(value) {
                let digits = value.replace(/\D/g, '');
                let length = digits.length;

                if (length <= 3) {
                return digits;
                } else if (length <= 6) {
                return `(${digits.slice(0, 3)}) ${digits.slice(3)}`;
                } else {
                return `(${digits.slice(0, 3)}) ${digits.slice(3, 6)}-${digits.slice(6)}`;
                }
                }
                """#)
                let value = context.evaluateScript("main(\(newValue))").toString()
                let maskFunction = context.objectForKeyedSubscript("phoneNumberMask")
                let maskedValue = maskFunction?.call(withArguments: [newValue])?.toString() ?? newValue
                DispatchQueue.main.async {
                    textValidator.text = maskedValue
                }
            }
    }

    // MARK: - Spacer
    @ViewBuilder func spacer() -> some View {
        let minLength = material.properties?.minLength.toCGFloat()
        Spacer(minLength: minLength)
    }

    @ViewBuilder func buildDefault() -> some View {
        switch material.type {
        case .ScrollView: scrollView()
        case .List: list()
        case .LazyVStack: lazyVstack()
        case .LazyHStack: lazyHstack()
        case .VStack: vstack()
        case .HStack: hstack()
        case .ZStack: zstack()
        case .Text: text()
        case .Image: image()
        case .Spacer: spacer()
        case .Rectangle: Rectangle()
        case .Divider: Divider()
        case .Circle: Circle()

        case .TextField: textField()

        // MARK: - ACTION IMPL

        default: EmptyView()
        }
    }

    @ViewBuilder func toPresentable() -> some View {
        let prop = material.properties
//        let action = Action.init(rawValue: prop?.action ?? "none")
        let uiComponent = buildDefault().embedInAnyView()
        uiComponent
            .modifier(ModifierFactory.PaddingModifier(
                padding: prop?.padding.toCGFloat()))
            .modifier(ModifierFactory.ForegroundModifier(
                foregroundColor: Color.pick[prop?.foregroundColor ?? "black"]))
            .modifier(ModifierFactory.BorderModifier(
                borderColor: Color.pick[prop?.borderColor ?? "black"],
                borderWidth: prop?.borderWidth.toCGFloat()
            ))
            .modifier(ModifierFactory.FrameModifier(
                width: prop?.width.toCGFloat(),
                height: prop?.height.toCGFloat()
            ))
            .onTapGesture {
                switch material.operation?.type {
                case .newScreen: break

                case .back:
                    presentationMode.wrappedValue.dismiss()
                case .universalLink:
                    if let url = URL(string: material.operation?.universalLink ?? "") {

                    }
                case .updateScreen:
                    viewManager?.todoListView()
                default:
                    break
                }
            }
        //                        Link("\(url)", destination: url)
        //                    viewManager.openView(material.nextScreenName)
//            .modifier(ModifierFactory.ActionModifier(action: {
//                switch action {
//                case .newScreen:
//                    break
//                case .back:
//                    presentationMode.wrappedValue.dismiss()
//                case .universalLink:
//                    if let url = URL(string: material.properties?.universalLink ?? "") {
//                        Link("\(url)", destination: url)
//                    }
//                case .updateScreen:
//                    break
//                default:
//                    break
//                }
//            }))
    }
}
