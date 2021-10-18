//
//  Formatters.swift
//  SamplePaymentApp
//
//  Copyright © 2021 Moonsense, Inc. All rights reserved.
//

import Foundation

struct Formatters {
    struct Numbers {
        private static let currencyFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            return formatter
        }()

        public static func getCurrencyString(from value: Double?, defaultValue: String = "") -> String {
            guard let value = value else {
                return defaultValue
            }

            return currencyFormatter.string(from: NSNumber(value: value)) ?? defaultValue
        }
    }
}
