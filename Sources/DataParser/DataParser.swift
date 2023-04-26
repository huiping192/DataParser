import Foundation
import ObjCDataParser

public class DataParser {
  private let parser: HPDataParser
  
  public init(start: String, end: String, bufferSize: Int = 2048) {
    parser = HPDataParser()
    parser.setBufferSize(bufferSize)
    parser.setStart(start)
    parser.setEnd(end)
  }
  
  public func appendData(_ data: String) {
    parser.appendData(data)
  }
  
  public func processData() -> String? {
    return parser.processData()
  }
}
