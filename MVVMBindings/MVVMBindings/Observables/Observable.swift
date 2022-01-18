//
//  Observable.swift
//  MVVMBindings
//
//  Created by monish-pt4649 on 20/01/22.
//

class Observable<T> {
    var value: T? {
        didSet {
            listener?(value)
            print("Setting the listener")
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}
