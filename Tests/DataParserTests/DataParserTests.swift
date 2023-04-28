import XCTest
@testable import DataParser

final class DataParserTests: XCTestCase {
  func testSimpleDataParsing() {
    let parser = DataParser(start: "\t{", end: "}\n", bufferSize: 2048)
    
    parser.appendData("Some random data\n".data(using: .utf8)!)
    parser.appendData("\t{\"key\":\"value\"}\nMore random data".data(using: .utf8)!)
    parser.appendData("\t{\"key2\":\"value2\"}\n".data(using: .utf8)!)
    
    let firstResult = parser.processData()
    XCTAssertEqual(String(data: firstResult!, encoding: .utf8), "\"key\":\"value\"")
    
    let secondResult = parser.processData()
    XCTAssertEqual(String(data: secondResult!, encoding: .utf8), "\"key2\":\"value2\"")
    
    XCTAssertNil(parser.processData())
  }
  
  func testSimpleDataParsing2() {
    let parser = DataParser(start: "\t{", end: "}\n", bufferSize: 2048)
    
    parser.appendData("Some random data\n\t".data(using: .utf8)!)
    XCTAssertNil(parser.processData())
    
    parser.appendData("{\"key\":\"value\"}\nMore random data".data(using: .utf8)!)
    
    let firstResult = parser.processData()
    XCTAssertEqual(String(data: firstResult!, encoding: .utf8), "\"key\":\"value\"")
    
    parser.appendData("\t{\"key2\":\"value2\"}\n".data(using: .utf8)!)
    
    let secondResult = parser.processData()
    XCTAssertEqual(String(data: secondResult!, encoding: .utf8), "\"key2\":\"value2\"")
    
    XCTAssertNil(parser.processData())
  }
  
  func testBufferExpansion() {
    let parser = DataParser(start: "\t{", end: "}\n", bufferSize: 32)
    
    let longData = String(repeating: "x", count: 64)
    parser.appendData("\t{\(longData)}\n".data(using: .utf8)!)
    
    let result = parser.processData()
    XCTAssertEqual(String(data: result!, encoding: .utf8), longData)
  }
  
  func testRemainingData() {
    let parser = DataParser(start: "\t{", end: "}\n", bufferSize: 2048)
    
    parser.appendData("Some random data\n".data(using: .utf8)!)
    XCTAssertNil(parser.processData())
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
}
