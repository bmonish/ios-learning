// assign(to:, on:)

// func assign<Root>(to keyPath: ReferenceWritableKeyPath<Root, Self.Output>, on object: Root) -> AnyCancellable
// ReferenceWritableKeyPath only available for property in class

// enables you to assign the received value to a KVO-Compliant property of an object

import Foundation
import Combine
import UIKit
import PlaygroundSupport


class MyClass {
    var anInt: Int = 0 {
        didSet {
            print("anInt was set to: \(anInt)")
        }
    }
}

var myObject = MyClass()
let myRange = (0...2)

let subscription = myRange.publisher
    .map { $0 * 10 }
    .assign(to: \.anInt, on: myObject)

//    The below sync does exactly what the assign above does
//    .sink { value in
//        myObject.anInt = value
//    }
