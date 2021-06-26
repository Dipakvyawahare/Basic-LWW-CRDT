//
//  LWWSetTests.swift
//  CloudNotesTests
//
//  Created by Dipak V. Vyawahare on 26/06/21.
//

import XCTest
@testable import CloudNotes

class LWWSetTests: XCTestCase {
    let subjectUnderTest = LWWSet<String>()

    func testAdd() {
        let value = "1"
        subjectUnderTest.add(value)
        XCTAssert(subjectUnderTest.values().contains(value), "Add Test failed")
    }

    func testRemoveEmpty() {
        let value = "1"
        subjectUnderTest.remove(value)
        XCTAssert(subjectUnderTest.values().contains(value) == false, "Remove Test failed")
    }

    func testRemoveFilled() {
        let value = "1"
        subjectUnderTest.add(value)
        subjectUnderTest.remove(value)
        XCTAssert(subjectUnderTest.values().contains(value) == false, "Remove Test failed")
    }

    func testRemoveNotExist() {
        let value = "1"
        let value2 = "2"
        subjectUnderTest.add(value)
        subjectUnderTest.remove(value2)
        XCTAssert(subjectUnderTest.values().contains(value2) == false, "Remove Test failed")
    }

    func testValues() {
        let value1 = "1"
        let value2 = "2"
        subjectUnderTest.add(value1)
        subjectUnderTest.add(value2)
        XCTAssert(subjectUnderTest.values().count == 2, "Values Test failed")
    }

    func testMerge() {
        let otherSet = LWWSet<String>()
        let value1 = "1"
        let value2 = "2"
        otherSet.add(value1)
        subjectUnderTest.add(value2)
        let mergedSet = subjectUnderTest.merge(otherSet)
        XCTAssert(mergedSet.values().count == 2, "Merge Test failed")
    }
}
