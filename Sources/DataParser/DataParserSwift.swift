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
  
  func processData() -> String? {
    if let startRange = buffer.range(of: startString.data(using: .utf8)!),
       let endRange = buffer[startRange.upperBound...].range(of: endString.data(using: .utf8)!) {
      
      let outputData = buffer.subdata(in: startRange.upperBound..<endRange.lowerBound)
      
      if let output = String(data: outputData, encoding: .utf8) {
        buffer.removeSubrange(buffer.startIndex..<endRange.upperBound)
        return output
      }
    }
    
    return nil
  }
  
  func getRemainingData() -> Data {
    return buffer
  }
}
