import XCTest
@testable import DataParser

final class DataParserTests: XCTestCase {
  func testSimpleDataParsing() {
    let parser = DataParser(start: "\t{", end: "}\n", bufferSize: 2048)
    
    parser.appendData("Some random data\n")
    parser.appendData("\t{\"key\":\"value\"}\nMore random data")
    parser.appendData("\t{\"key2\":\"value2\"}\n")
    
    let firstResult = parser.processData()
    XCTAssertEqual(firstResult, "\"key\":\"value\"")
    
    let secondResult = parser.processData()
    XCTAssertEqual(secondResult, "\"key2\":\"value2\"")
    
    XCTAssertNil(parser.processData())
  }
  
  func testSimpleDataParsing2() {
    let parser = DataParser(start: "\t{", end: "}\n", bufferSize: 2048)
    
    parser.appendData("Some random data\n\t")
    XCTAssertNil(parser.processData())
    
    parser.appendData("{\"key\":\"value\"}\nMore random data")
    
    let firstResult = parser.processData()
    XCTAssertEqual(firstResult, "\"key\":\"value\"")
    
    parser.appendData("\t{\"key2\":\"value2\"}\n")
    
    let secondResult = parser.processData()
    XCTAssertEqual(secondResult, "\"key2\":\"value2\"")
    
    XCTAssertNil(parser.processData())
  }
  
  func testBufferExpansion() {
    let parser = DataParser(start: "\t{", end: "}\n", bufferSize: 32)
    
    let longData = String(repeating: "x", count: 64)
    parser.appendData("\t{\(longData)}\n")
    
    let result = parser.processData()
    XCTAssertEqual(result, longData)
  }
}
