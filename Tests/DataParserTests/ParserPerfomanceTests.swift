import XCTest
@testable import DataParser

final class ParserPerfomanceTests: XCTestCase {
  
  let testCounts = 30000
  
  func testParserPerformanceC() {
    let testData = generateTestData()
    
    let parser = DataParser(start: "<data>", end: "</data>")
    
    self.measure {
      parser.appendData(testData)
      var count = 0
      
      while let _ = parser.processData() {
        count += 1
      }
      
      XCTAssertEqual(count, testCounts, "Processed data count should be \(testCounts)")
    }
  }
  
  func testParserPerformanceSwift() {
    let testData = generateTestData()
    
    let parser = DataParserSwift(start: "<data>", end: "</data>")
    
    self.measure {
      parser.appendData(testData)
      var count = 0
      
      while let _ = parser.processData() {
        count += 1
      }
      
      XCTAssertEqual(count, testCounts, "Processed data count should be \(testCounts)")
    }
  }
  
  private func generateTestData() -> Data {
    var data = "Some random data\n"
    let item = "<data>sample data</data>"
    
    for _ in 0..<testCounts {
      data += "\(item)\n"
    }
    
    data += "More random data"
    
    return data.data(using: .utf8)!
  }
  
}
