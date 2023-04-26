import XCTest
@testable import DataParser

final class DataParserTests: XCTestCase {
  func testSimpleDataParsing() {
    let parser = DataParser()
    parser.setBufferSize(2048)
    parser.setStartString("\t{")
    parser.setEndString("}\n")
    
    parser.appendData("Some random data\n")
    parser.appendData("\t{\"key\":\"value\"}\nMore random data")
    parser.appendData("\t{\"key2\":\"value2\"}\n")
    
    let firstResult = parser.processData()
    XCTAssertEqual(firstResult, "\"key\":\"value\"")
    
    let secondResult = parser.processData()
    XCTAssertEqual(secondResult, "\"key2\":\"value2\"")
    
    XCTAssertNil(parser.processData())
  }
  
  func testBufferExpansion() {
    let parser = DataParser()
    parser.setBufferSize(32)
    parser.setStartString("\t{")
    parser.setEndString("}\n")
    
    let longData = String(repeating: "x", count: 64)
    parser.appendData("\t{\(longData)}\n")
    
    let result = parser.processData()
    XCTAssertEqual(result, longData)
  }
}
