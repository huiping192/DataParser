import XCTest
@testable import DataParser

final class DataParserTests: XCTestCase {
//  func testSimpleDataParsing() {
//    let parser = DataParser(start: "\t{", end: "}\n", bufferSize: 2048)
//    
//    parser.appendData("Some random data\n".data(using: .utf8)!)
//    parser.appendData("\t{\"key\":\"value\"}\nMore random data".data(using: .utf8)!)
//    parser.appendData("\t{\"key2\":\"value2\"}\n".data(using: .utf8)!)
//    
//    let firstResult = parser.processData()
//    XCTAssertEqual(String(data: firstResult!, encoding: .utf8), "\"key\":\"value\"")
//    
//    let secondResult = parser.processData()
//    XCTAssertEqual(String(data: secondResult!, encoding: .utf8), "\"key2\":\"value2\"")
//    
//    XCTAssertNil(parser.processData())
//  }
//  
//  func testSimpleDataParsing2() {
//    let parser = DataParser(start: "\t{", end: "}\n", bufferSize: 2048)
//    
//    parser.appendData("Some random data\n\t".data(using: .utf8)!)
//    XCTAssertNil(parser.processData())
//    
//    parser.appendData("{\"key\":\"value\"}\nMore random data".data(using: .utf8)!)
//    
//    let firstResult = parser.processData()
//    XCTAssertEqual(String(data: firstResult!, encoding: .utf8), "\"key\":\"value\"")
//    
//    parser.appendData("\t{\"key2\":\"value2\"}\n".data(using: .utf8)!)
//    
//    let secondResult = parser.processData()
//    XCTAssertEqual(String(data: secondResult!, encoding: .utf8), "\"key2\":\"value2\"")
//    
//    XCTAssertNil(parser.processData())
//  }
//  
//  func testBufferExpansion() {
//    let parser = DataParser(start: "\t{", end: "}\n", bufferSize: 32)
//    
//    let longData = String(repeating: "x", count: 64)
//    parser.appendData("\t{\(longData)}\n".data(using: .utf8)!)
//    
//    let result = parser.processData()
//    XCTAssertEqual(String(data: result!, encoding: .utf8), longData)
//  }
  
  func testRemainingData() {
    let parser = DataParser(start: "\t{", end: "}\n", bufferSize: 2048)
    
    parser.appendData("Some random data\n".data(using: .utf8)!)
    XCTAssertNil(parser.processData())
    print("Remaining data before XCTAssertEqual: \(String(data: parser.remainingData!, encoding: .utf8)!)")
    XCTAssertEqual(String(data: parser.remainingData!, encoding: .utf8), "Some random data\n")
    
    parser.appendData("\t{\"key\":\"value\"}\nMore random data".data(using: .utf8)!)
    let firstResult = parser.processData()
    XCTAssertEqual(String(data: firstResult!, encoding: .utf8), "\"key\":\"value\"")
    XCTAssertEqual(String(data: parser.remainingData!, encoding: .utf8), "More random data")
    
    parser.appendData("\t{\"key2\":\"value2\"}\n".data(using: .utf8)!)
    let secondResult = parser.processData()
    XCTAssertEqual(String(data: secondResult!, encoding: .utf8), "\"key2\":\"value2\"")
    
    XCTAssertNil(parser.processData())
  }
  
//  func testRemoveUnnecessaryData() {
//    let parser = DataParser(start: "<", end: ">", bufferSize: 2048)
//
//    parser.appendData("abc<123>xyz".data(using: .utf8)!)
//
//    let processedData = parser.processData()
//    XCTAssertEqual(String(data: processedData!, encoding: .utf8), "123")
//
//    let remainingData = parser.remainingData
//    XCTAssertEqual(String(data: remainingData!, encoding: .utf8), "xyz")
//  }
//
//  func testProcessAllData() {
//      let parser = DataParser(start: "\t{", end: "}\n", bufferSize: 2048)
//
//      parser.appendData("Some random data\n".data(using: .utf8)!)
//      parser.appendData("\t{\"key\":\"value\"}\nMore random data".data(using: .utf8)!)
//      parser.appendData("\t{\"key2\":\"value2\"}\n".data(using: .utf8)!)
//
//      let results = parser.processAllData()
//      XCTAssertEqual(results.count, 2)
//      XCTAssertEqual(String(data: results[0], encoding: .utf8), "\"key\":\"value\"")
//      XCTAssertEqual(String(data: results[1], encoding: .utf8), "\"key2\":\"value2\"")
//    }
}
