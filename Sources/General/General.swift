//
//  General.swift
//  Algorithms&DataStructures
//
//  Created by Paul Kraft on 13.09.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

import Foundation

public func * (lhs: String, rhs: UInt) -> String {
	guard rhs > 1 else {
        guard rhs > 0 else { return "" }
        return lhs
    }
	let result	= lhs * (rhs >> 1)
	guard rhs & 0x1 == 0 else {
        return result + result + lhs
    }
	return result + result
}

public func * (lhs: UInt, rhs: String) -> String {
    return rhs * lhs
}

public func * (lhs: Int, rhs: String) -> String {
    return rhs * UInt(lhs)
}

public func * (lhs: String, rhs: Int) -> String {
    return lhs * UInt(rhs)
}

public enum DataStructureError: Error {
    case notIn, alreadyIn
}

extension Int {
    func description(radix: Int) -> String {
        guard radix > 0 && radix < 65 else {
            return "Cannot create description with radix: \(radix)"
        }
        let nums = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/"
            .unicodeScalars.map { String($0) }
        var str = nums[self % radix]
        var num = self / radix
        while num != 0 {
            str = nums[num % radix] + str
            num /= radix
        }
        return str
    }
}

extension Sequence {
    public func shuffled() -> [Element] {
        return sorted(by: { _, _ in arc4random() & 1 == 0 })
    }
}

extension Array {
    public mutating func shuffle() {
        sort(by: { _, _ in arc4random() & 1 == 0 })
    }
}

extension Array where Element: Equatable {
    public mutating func remove(_ element: Element) {
        guard let index = index(of: element) else {
            return
        }
        remove(at: index)
    }
}

var cacheLineSize: Int {
    var a: size_t = 0
    var b: size_t = MemoryLayout<Int>.size
    var c: size_t = 0
    sysctlbyname("hw.cachelinesize", &a, &b, &c, 0)
    return a
}
