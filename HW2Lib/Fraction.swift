//
//  Fraction.swift
//  HW2Lib
//
//  Created by Rohan Panchal on 1/12/24.
//

import Foundation

class Fraction : CustomStringConvertible {
    var numerator: Int = 0
    var denominator: Int = 1
    
    init(_ numerator: Int, over denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
        normalize()
    }
    
    init() {}
    
    private func normalize() {
        if (denominator < 0) {
            denominator = -denominator
            numerator = -numerator
        }
        reduce()
    }
    
    func setTo(numerator: Int, over denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
        normalize()
    }
    
    var description: String {
        return "\(numerator)/\(denominator)"
    }

    func print() {
        Swift.print("\(numerator)/\(denominator)")
    }
    
    func toDouble() -> Double {
        return Double(numerator) / Double(denominator);
    }
    
    func reduce() {
        var u = abs(numerator)
        var v = denominator
        var r: Int
        while (v != 0) {
            r = u % v; u = v; v = r
        }
        numerator /= u
        denominator /= u
    }
    
    func add(_ f: Fraction) -> Fraction {
        let result: Fraction = Fraction()
        result.numerator = numerator * f.denominator + denominator * f.numerator
        result.denominator = denominator * f.denominator
        result.reduce()
        return result
    }
    
    static func +(a: Fraction, b: Fraction) -> Fraction {
        return a.add(b)
    }
    
    static func +=(left: inout Fraction, right: Fraction) {
        left = left + right
    }
    
    /*
     Make your changes here
     */
}

func add(_ a: Fraction, _ b: Fraction) -> Fraction {
    return a.add(b)
}

/*
 ... And here
 */
