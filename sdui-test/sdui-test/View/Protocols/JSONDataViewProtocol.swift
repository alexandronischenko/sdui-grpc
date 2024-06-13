//
//  JSONDataViewProtocol.swift
//  sdui-test
//
//  Created by Alexandr Onischenko on 13.04.2024.
//

import Foundation
import UIKit

internal protocol JSONDataViewProtocol: PresentableProtocol {
    var json: Data { get }

    init(json: Data)
}

