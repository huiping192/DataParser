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
  
  public func processData() -> Data? {
    return parser.processData()
  }
  
  public var remainingData: Data? {
    parser.remainingData()
  }
}
