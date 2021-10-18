//
//  Cookie.swift
//  SamplePaymentApp
//
//  Copyright © 2021 Moonsense, Inc. All rights reserved.
//

import Foundation

class Cookie {
    let name: String
    let price: Double

    private(set) var quantity: Int

    var totalPrice: Double {
        get {
            return Double(quantity) * price
        }
    }

    init(name: String, price: Double, initialQuantity: Int = 0) {
        self.name = name
        self.price = price
        self.quantity = initialQuantity
    }

    func addCookie() {
        quantity += 1
    }

    func removeCookie() {
        if quantity > 0 {
            quantity -= 1
        }
    }
}
