//
//  ProtocolsAndExtensions.swift
//  domain-modeling
//
//  Created by Jooneil Ahn on 10/20/15.
//  Copyright © 2015 Jooneil Ahn. All rights reserved.
//



import Foundation

protocol CustomStringConvertible {
    var description: String { get }
}

protocol Mathematics {
    mutating func add(addNum : Double, addCurr : String) -> Void
    mutating func subtract(subNum : Double, subCurr : String) -> Void
}

extension Double {
    var USD: Money { return Money(amount: self, currency: "USD") }
    var EUR: Money { return Money(amount: self, currency: "EUR") }
    var CAN: Money { return Money(amount: self, currency: "CAN") }
    var GBP: Money { return Money(amount: self, currency: "GBP") }
}

