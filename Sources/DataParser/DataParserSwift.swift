import Foundation

class DataParserSwift {
  private(set) var buffer: Data = Data()
  private(set) var bufferSize: Int
  private(set) var startString: String
  private(set) var endString: String
  
  init(start: String, end: String, bufferSize: Int = 2048) {
    self.bufferSize = bufferSize
    self.startString = start
    self.endString = end
  }
  
  func appendData(_ data: Data) {
    buffer.append(data)
  }
  
  func processData() -> Data? {
    if let startRange = buffer.range(of: startString.data(using: .utf8)!),
       let endRange = buffer[startRange.upperBound...].range(of: endString.data(using: .utf8)!) {
      
      let outputData = buffer.subdata(in: startRange.upperBound..<endRange.lowerBound)
      
      buffer.removeSubrange(buffer.startIndex..<endRange.upperBound)
      return outputData
    }
    
    return nil
  }
  
  func getRemainingData() -> Data {
    return buffer
  }
}
