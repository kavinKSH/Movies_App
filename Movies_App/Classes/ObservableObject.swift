//
//  ObservableObject.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

class Observable <T> {
    var listner: ((T?)->Void)?
    var value: T? {
        didSet {
            self.listner?(self.value)
        }
    }
    
    init(value: T?) {
        self.value = value
    }
    
    func bind(_ listner: @escaping (T?)->Void) {
        listner(value)
        self.listner = listner
    }
}
