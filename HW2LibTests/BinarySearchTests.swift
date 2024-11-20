//
//  BinarySearchTests.swift
//  HW2LibTests
//
//  Created by Rohan Panchal on 1/14/24.
//

import XCTest
@testable import HW2Lib

final class BinarySearchTests: XCTestCase {
    
    // Test 1.A
    // Points: 10
    func testEmptyArrayShouldReturnUnknownIndex() {
        
        let array: [Int] = []
        let key = 0
        
        let expected = -1
        
        let result = binarySearch(key: key, array: array)
        
        XCTAssertEqual(result, expected)
    }
    
    // Test 1.B
    // Points: 10
    func testSingleElementArrayShouldReturnProperIndexOnMatch() {
        
        let array: [Int] = [1]
        let key = 1
        
        let expected = 0
        
        let result = binarySearch(key: key, array: array)
        
        XCTAssertEqual(result, expected)
    }
    
    // Test 1.C
    // Points: 10
    func testSingleElementArrayShouldReturnUnknownIndexOnNoMatch() {
        
        let array: [Int] = [1]
        let key = 2
        
        let expected = -1
        
        let result = binarySearch(key: key, array: array)
        
        XCTAssertEqual(result, expected)
    }
    
    // Test 1.D
    // Points: 10
    func testUnsortedArrayShouldReturnUnknownIndex() {
        
        let array: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].reversed()
        let key = 5
        
        let expected = -1
        
        let result = binarySearch(key: key, array: array)
        
        XCTAssertEqual(result, expected)
    }
    
    // Test 1.E
    // Points: 10
    func testSortedArrayShouldReturnUnknownIndex() {
        
        let array: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let key = 5
        
        let expected = 4
        
        let result = binarySearch(key: key, array: array)
        
        XCTAssertEqual(result, expected)
    }
}
