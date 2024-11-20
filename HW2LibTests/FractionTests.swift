//
//  FractionTests.swift
//  HW2LibTests
//
//  Created by Rohan Panchal on 1/14/24.
//

import XCTest
@testable import HW2Lib

// 5 Pts for getting tests to compile
final class FractionTests: XCTestCase {
    
    /*
     Addition
     */
    
    // 2.A EXAMPLE
    // POINTS: 0
    func testAdditionOperatorShouldReturnCorrectValueAndNotModifyLeftValue() {
        
        let lFraction = Fraction(1, over: 2)
        let rFraction = Fraction(1, over: 4)
        
        let expected = Fraction(3, over: 4)
        
        var result: Fraction
        
        /* ---------------- */
        
        result = lFraction + rFraction
        
        XCTAssertEqual(result, expected)
        XCTAssertEqual(lFraction, Fraction(1, over: 2)) // <-- Original Value unmodified
    }
    
    // 2.B EXAMPLE
    // POINTS: 0
    func testAdditionCompoundAssignmentShouldReturnCorrectValueAndModifyLeftValue() {
        
        var lFraction = Fraction(1, over: 2)
        let rFraction = Fraction(1, over: 4)
        
        let expected = Fraction(3, over: 4)
        
        /* ---------------- */
        
        lFraction += rFraction
        
        XCTAssertEqual(lFraction, expected) // <-- Original Value MODIFIED
    }
    
    // 2.C EXAMPLE
    // POINTS: 0
    func testAdditionMethodShouldReturnCorrectValueAndNotModifyLeftValue() {
        
        let lFraction = Fraction(1, over: 2)
        let rFraction = Fraction(1, over: 4)
        
        let expected = Fraction(3, over: 4)
        
        var result: Fraction
        
        /* ---------------- */
        
        result = lFraction.add(rFraction)
        
        XCTAssertEqual(result, expected)
        XCTAssertEqual(lFraction, Fraction(1, over: 2)) // <-- Original Value unmodified
    }
    
    /*
     Subtraction
     */
    
    // 2.D EXAMPLE
    // POINTS: 5
    func testSubtractionOperatorShouldReturnCorrectValueAndNotModifyLeftValue() {
        
        let lFraction = Fraction(1, over: 2)
        let rFraction = Fraction(1, over: 4)
        
        let expected = Fraction(1, over: 4)
        
        var result: Fraction
        
        /* ---------------- */
        
        result = lFraction - rFraction
        
        XCTAssertEqual(result, expected)
        XCTAssertEqual(lFraction, Fraction(1, over: 2)) // <-- Original Value unmodified
    }
    
    // 2.E EXAMPLE
    // POINTS: 5
    func testSubtractionCompoundAssignmentShouldReturnCorrectValueAndModifyLeftValue() {
        
        var lFraction = Fraction(1, over: 2)
        let rFraction = Fraction(1, over: 4)
        
        let expected = Fraction(1, over: 4)
        
        /* ---------------- */
        
        lFraction -= rFraction
        
        XCTAssertEqual(lFraction, expected) // <-- Original Value MODIFIED
    }
    
    // 2.F EXAMPLE
    // POINTS: 5
    func testSubtractionMethodShouldReturnCorrectValueAndNotModifyLeftValue() {
        
        let lFraction = Fraction(1, over: 2)
        let rFraction = Fraction(1, over: 4)
        
        let expected = Fraction(1, over: 4)
        
        var result: Fraction
        
        /* ---------------- */
        
        result = lFraction.subtract(rFraction)
        
        XCTAssertEqual(result, expected)
        XCTAssertEqual(lFraction, Fraction(1, over: 2)) // <-- Original Value unmodified
    }
    
    /*
     Multiplication
     */
    
    // 2.G EXAMPLE
    // POINTS: 5
    func testMultiplicationOperatorShouldReturnCorrectValueAndNotModifyLeftValue() {
        
        let lFraction = Fraction(1, over: 2)
        let rFraction = Fraction(1, over: 2)
        
        let expected = Fraction(1, over: 4)
        
        var result: Fraction
        
        /* ---------------- */
        
        result = lFraction * rFraction
        
        XCTAssertEqual(result, expected)
        XCTAssertEqual(lFraction, Fraction(1, over: 2)) // <-- Original Value unmodified
    }
    
    // 2.H EXAMPLE
    // POINTS: 5
    func testMultiplicationCompoundAssignmentShouldReturnCorrectValueAndModifyLeftValue() {
        
        var lFraction = Fraction(1, over: 2)
        let rFraction = Fraction(1, over: 2)
        
        let expected = Fraction(1, over: 4)
        
        /* ---------------- */
        
        lFraction *= rFraction
        
        XCTAssertEqual(lFraction, expected) // <-- Original Value MODIFIED
    }
    
    // 2.I EXAMPLE
    // POINTS: 5
    func testMultiplicationMethodShouldReturnCorrectValueAndNotModifyLeftValue() {
        
        let lFraction = Fraction(1, over: 2)
        let rFraction = Fraction(1, over: 2)
        
        let expected = Fraction(1, over: 4)
        
        var result: Fraction
        
        /* ---------------- */
        
        result = lFraction.multiply(rFraction)
        
        XCTAssertEqual(result, expected)
        XCTAssertEqual(lFraction, Fraction(1, over: 2)) // <-- Original Value unmodified
    }
    
    /*
     Division
     */
    
    // 2.J EXAMPLE
    // POINTS: 5
    func testDivisionOperatorShouldReturnCorrectValueAndNotModifyLeftValue() {
        
        let lFraction = Fraction(1, over: 2)
        let rFraction = Fraction(1, over: 4)
        
        let expected = Fraction(2, over: 1)
        
        var result: Fraction
        
        /* ---------------- */
        
        result = lFraction / rFraction
        
        XCTAssertEqual(result, expected)
        XCTAssertEqual(lFraction, Fraction(1, over: 2)) // <-- Original Value unmodified
    }
    
    // 2.K EXAMPLE
    // POINTS: 5
    func testDivisionCompoundAssignmentShouldReturnCorrectValueAndModifyLeftValue() {
        
        var lFraction = Fraction(1, over: 2)
        let rFraction = Fraction(1, over: 4)
        
        let expected = Fraction(2, over: 1)
        
        /* ---------------- */
        
        lFraction /= rFraction
        
        XCTAssertEqual(lFraction, expected) // <-- Original Value MODIFIED
    }
    
    // 2.L EXAMPLE
    // POINTS: 5
    func testDivisionMethodShouldReturnCorrectValueAndNotModifyLeftValue() {
        
        let lFraction = Fraction(1, over: 2)
        let rFraction = Fraction(1, over: 4)
        
        let expected = Fraction(2, over: 1)
        
        var result: Fraction
        
        /* ---------------- */
        
        result = lFraction.divide(rFraction)
        
        XCTAssertEqual(result, expected)
        XCTAssertEqual(lFraction, Fraction(1, over: 2)) // <-- Original Value unmodified
    }
}
