import XCTest
@testable import DataParser

final class ParserPerfomanceTests: XCTestCase {
  
  let testCounts = 1000000
  
  func testPerformanceComparison() {
    let cPerformance = testParserPerformanceC()
    let swiftPerformance = testParserPerformanceSwift()
    
    let percentageDifference = ((swiftPerformance / cPerformance) - 1) * 100
    print("C time: \(cPerformance) seconds, Swift time: \(swiftPerformance) seconds")
    print("C is better by \(percentageDifference)%")
  }
  
  func measurePerformance(_ block: () -> Void) -> TimeInterval {
    let startTime = Date()
    block()
    let endTime = Date()
    
    return endTime.timeIntervalSince(startTime)
  }
  func testParserPerformanceC() -> TimeInterval {
    let parser = DataParser(start: "<data>", end: "</data>")
    
    return measurePerformance {
      for _ in 0 ..< testCounts {
        parser.appendData(generateTestData)
        _ = parser.processData()
      }
    }
  }
  
  func testParserPerformanceSwift() -> TimeInterval {
    let parser = DataParserSwift(start: "<data>", end: "</data>")
    
    return measurePerformance {
      for _ in 0 ..< testCounts {
        parser.appendData(generateTestData)
        _ = parser.processData()
      }
    }
  }
  
  private var generateTestData: Data = {
    var data = "Some random data\n"
    let item = "<data>sample data</data>"
    data += "\(item)\n"
    data += "More random data"
    
    return data.data(using: .utf8)!
  }()
  
}
