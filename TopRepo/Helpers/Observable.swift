//
//  Observable.swift
// TopRepo
//
//  Created by Sajjad Sarkoobi on 9.11.2022.
//

import Foundation

class Observable<T> {
    
    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.listner?(self.value)
            }
        }
    }
    
    init(_ value: T? = nil) {
        self.value = value
    }
    
    private var listner: ((T?) -> Void)?
    
    func bind(_ listner: @escaping ((T?) -> Void)) {
        listner(value)
        self.listner = listner
    }
}
