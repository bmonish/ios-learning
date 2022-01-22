import Combine

class MyClass {
    var anInt: Int = 0 {
        didSet {
            print("didSet \(anInt)")
        }
    }
}

let obj = MyClass()
let pub = (0...2).publisher
let subscriber = Subscribers.Assign(object: obj, keyPath: \.anInt)

let cancellable = pub
    .print("🔥")
    .receive(subscriber: subscriber)
