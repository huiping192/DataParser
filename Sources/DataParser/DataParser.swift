import Foundation
import ObjCDataParser

public class DataParser {
  private let parser: HPDataParser
  
  public init(start: String, end: String, bufferSize: Int = 2048) {
    parser = HPDataParser()
    parser.setBufferSize(bufferSize)
    parser.setStartString(start.data(using: .utf8))
    parser.setEndString(end.data(using: .utf8))
  }
  
  public func appendData(_ data: Data) {
    parser.append(data)
  }
  
  public func processData() -> String? {
    guard let processedData = parser.processData() else {
      return nil
    }
    return String(data: processedData, encoding: .utf8)
  }
  
  public var remainingData: String? {
    guard let remainingData = parser.remainingData() else {
      return nil
    }
    return String(data: remainingData, encoding: .utf8)
  }
}
