import XCTest
import DynamicSwift

class JSONTests: XCTestCase {
    func testHelpers() throws {
        var json: JSON = nil
        XCTAssertTrue(json.isNull)
        XCTAssertFalse(json.isBool)
        XCTAssertFalse(json.isInt)
        XCTAssertFalse(json.isDouble)
        XCTAssertFalse(json.isString)
        XCTAssertFalse(json.isArray)
        XCTAssertFalse(json.isDictionary)
        XCTAssertEqual(json, nil)
        XCTAssertNil(json.bool)
        XCTAssertNotEqual(json, true)
        XCTAssertNotEqual(json, false)
        XCTAssertNil(json.int)
        XCTAssertNotEqual(json, 0)
        XCTAssertNil(json.double)
        XCTAssertNotEqual(json, 0)
        XCTAssertNil(json.string)
        XCTAssertNotEqual(json, "")
        XCTAssertNotEqual(json, "nil")
        XCTAssertNil(json.array)
        XCTAssertNotEqual(json, [])
        XCTAssertNil(json.dictionary)
        XCTAssertNotEqual(json, [:])

        json = true
        XCTAssertFalse(json.isNull)
        XCTAssertTrue(json.isBool)
        XCTAssertFalse(json.isInt)
        XCTAssertFalse(json.isDouble)
        XCTAssertFalse(json.isString)
        XCTAssertFalse(json.isArray)
        XCTAssertFalse(json.isDictionary)
        XCTAssertEqual(json.bool, true)
        XCTAssertEqual(json, true)
        XCTAssertNotEqual(json, false)
        XCTAssertNil(json.int)
        XCTAssertNotEqual(json, 1)
        XCTAssertNil(json.double)
        XCTAssertNotEqual(json, 1.0)
        XCTAssertNil(json.string)
        XCTAssertNotEqual(json, "")
        XCTAssertNotEqual(json, "true")
        XCTAssertNil(json.array)
        XCTAssertNotEqual(json, [])
        XCTAssertNil(json.dictionary)
        XCTAssertNotEqual(json, [:])

        json = 14
        XCTAssertFalse(json.isNull)
        XCTAssertFalse(json.isBool)
        XCTAssertTrue(json.isInt)
        XCTAssertFalse(json.isDouble)
        XCTAssertFalse(json.isString)
        XCTAssertFalse(json.isArray)
        XCTAssertFalse(json.isDictionary)
        XCTAssertNil(json.bool)
        XCTAssertNotEqual(json, true)
        XCTAssertNotEqual(json, false)
        XCTAssertEqual(json.int, 14)
        XCTAssertEqual(json, 14)
        XCTAssertNotEqual(json, 15)
        XCTAssertNil(json.double)
        XCTAssertNotEqual(json, 1.0)
        XCTAssertNil(json.string)
        XCTAssertNotEqual(json, "")
        XCTAssertNotEqual(json, "14")
        XCTAssertNil(json.array)
        XCTAssertNotEqual(json, [])
        XCTAssertNil(json.dictionary)
        XCTAssertNotEqual(json, [:])

        json = 5.67
        XCTAssertFalse(json.isNull)
        XCTAssertFalse(json.isBool)
        XCTAssertFalse(json.isInt)
        XCTAssertTrue(json.isDouble)
        XCTAssertFalse(json.isString)
        XCTAssertFalse(json.isArray)
        XCTAssertFalse(json.isDictionary)
        XCTAssertNil(json.bool)
        XCTAssertNotEqual(json, true)
        XCTAssertNotEqual(json, false)
        XCTAssertNil(json.int)
        XCTAssertNotEqual(json, 5)
        XCTAssertEqual(json.double!, 5.67, accuracy: 0.001)
        XCTAssertEqual(json, 5.67)
        XCTAssertNotEqual(json, 8.24)
        XCTAssertNil(json.string)
        XCTAssertNotEqual(json, "")
        XCTAssertNotEqual(json, "5.67")
        XCTAssertNil(json.array)
        XCTAssertNotEqual(json, [])
        XCTAssertNil(json.dictionary)
        XCTAssertNotEqual(json, [:])

        json = "Hello World"
        XCTAssertFalse(json.isNull)
        XCTAssertFalse(json.isBool)
        XCTAssertFalse(json.isInt)
        XCTAssertFalse(json.isDouble)
        XCTAssertTrue(json.isString)
        XCTAssertFalse(json.isArray)
        XCTAssertFalse(json.isDictionary)
        XCTAssertNil(json.bool)
        XCTAssertNotEqual(json, true)
        XCTAssertNotEqual(json, false)
        XCTAssertNil(json.int)
        XCTAssertNotEqual(json, 0)
        XCTAssertNil(json.double)
        XCTAssertNotEqual(json, 0.0)
        XCTAssertEqual(json.string, "Hello World")
        XCTAssertEqual(json, "Hello World")
        XCTAssertNotEqual(json, "Hello SwiftIsland")
        XCTAssertNil(json.array)
        XCTAssertNotEqual(json, [])
        XCTAssertNil(json.dictionary)
        XCTAssertNotEqual(json, [:])

        json = [true, 34, 7.8, "Swift Island"]
        XCTAssertFalse(json.isNull)
        XCTAssertFalse(json.isBool)
        XCTAssertFalse(json.isInt)
        XCTAssertFalse(json.isDouble)
        XCTAssertFalse(json.isString)
        XCTAssertTrue(json.isArray)
        XCTAssertFalse(json.isDictionary)
        XCTAssertNil(json.bool)
        XCTAssertNotEqual(json, true)
        XCTAssertNotEqual(json, false)
        XCTAssertNil(json.int)
        XCTAssertNotEqual(json, 0)
        XCTAssertNil(json.double)
        XCTAssertNotEqual(json, 0.0)
        XCTAssertNil(json.string)
        XCTAssertNotEqual(json, "")
        XCTAssertEqual(json.array, [true, 34, 7.8, "Swift Island"])
        XCTAssertEqual(json, [true, 34, 7.8, "Swift Island"])
        XCTAssertNotEqual(json, [false, 42, 6])
        XCTAssertNil(json.dictionary)
        XCTAssertNotEqual(json, [:])

        json = ["name": "Swift", "isAwesome": true]
        XCTAssertFalse(json.isNull)
        XCTAssertFalse(json.isBool)
        XCTAssertFalse(json.isInt)
        XCTAssertFalse(json.isDouble)
        XCTAssertFalse(json.isString)
        XCTAssertFalse(json.isArray)
        XCTAssertTrue(json.isDictionary)
        XCTAssertNil(json.bool)
        XCTAssertNotEqual(json, true)
        XCTAssertNotEqual(json, false)
        XCTAssertNil(json.int)
        XCTAssertNotEqual(json, 0)
        XCTAssertNil(json.double)
        XCTAssertNotEqual(json, 0.0)
        XCTAssertNil(json.string)
        XCTAssertNotEqual(json, "")
        XCTAssertNil(json.array)
        XCTAssertNotEqual(json, [])
        XCTAssertEqual(json.dictionary, ["name": "Swift", "isAwesome": true])
        XCTAssertEqual(json, ["name": "Swift", "isAwesome": true])
        XCTAssertNotEqual(json, ["name": "Objective-C", "isAwesome": false])
    }

    func testArrayAccess() {
        let json: JSON = [true, "Swift", 42]
        XCTAssertEqual(json[2], 42)
        XCTAssertTrue(json[2][0].isUndefined)
        XCTAssertTrue(json[3].isUndefined)
    }

//    func testDynamicMemberLookup() {
//        let json: JSON = [
//            "conferences": [
//                [
//                    "name": "Swift Island",
//                    "isFull": true,
//                    "longitude": 53.079758,
//                    "latitude": 4.802859
//                ], [
//                    "name": "Swift Alps",
//                    "numberOfDays": 2,
//                    "isFull": false,
//                    "longitude": 46.305125,
//                    "latitude": 7.462249
//                ]
//            ]
//        ]
//
//        XCTAssertEqual(json.conferences[0].name, "Swift Island")
//        XCTAssertTrue(json.confs[0].name.isUndefined)
//    }
}
