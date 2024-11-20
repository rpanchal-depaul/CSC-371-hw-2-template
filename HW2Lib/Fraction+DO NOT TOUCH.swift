//
//  Fraction+DO NOT TOUCH.swift
//  HW2Lib
//
//  Created by Rohan Panchal on 1/14/24.
//
//  DO NOT MODIFY THIS FILE
//

import Foundation

extension Fraction: Equatable {
    static func == (lhs: Fraction, rhs: Fraction) -> Bool {
        return (lhs.numerator == rhs.numerator) && (lhs.denominator == rhs.denominator)
    }
}
