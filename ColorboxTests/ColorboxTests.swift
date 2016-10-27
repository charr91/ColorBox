//
//  ColorboxTests.swift
//  ColorboxTests
//
//  Created by Cliff Harris on 10/26/16.
//  Copyright © 2016 Clifford Harris. All rights reserved.
//

import XCTest

class ColorboxTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testColorSort() {
        let brightest = ColorDetails(hex: "", name: "Brightest", description: "", rgb: [250, 231, 181])
        let secondBrightest = ColorDetails(hex: "", name: "secondBrightest", description: "", rgb: [172, 229, 238])
        let secondDarkest = ColorDetails(hex: "", name: "secondDarkest", description: "", rgb: [255, 164, 116])
        let darkest = ColorDetails(hex: "", name: "darkest", description: "", rgb: [159, 129, 112])
        
        let unorderedColors = [secondDarkest, brightest, darkest, secondBrightest]
        let expectedResult = [brightest, secondBrightest, secondDarkest, darkest]
        
        let result = ColorBoxAPI.sortColorsByBrightnessDescending(colors: unorderedColors)
        XCTAssertTrue(result.elementsEqual(expectedResult, by: { (a, b) -> Bool in
            a.name == b.name
        }))
    }
}
