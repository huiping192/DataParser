import Foundation
import ObjCDataParser

public class DataParser {
  private let parser: HPDataParser
  
  public init() {
    parser = HPDataParser()
  }
  
  public func setBufferSize(_ size: Int) {
    parser.setBufferSize(size)
  }
  
  public func setStartString(_ start: String) {
    parser.setStart(start)
  }
  
  public func setEndString(_ end: String) {
    parser.setEnd(end)
  }
  
  public func appendData(_ data: String) {
    parser.appendData(data)
  }
  
  public func processData() -> String? {
    return parser.processData()
  }
}
