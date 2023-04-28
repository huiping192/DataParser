# DataParser

DataParser is a Swift package that provides a simple and efficient way to parse structured data from unstructured input streams. It is especially useful when working with streaming data sources that might include data wrapped in custom delimiters. The library is designed to be flexible, allowing you to configure buffer size and start/end strings for your specific parsing needs.

## Features

- Configurable buffer size
- Customizable start and end strings for data parsing
- Efficient memory management
- Supports Swift Package Manager

## Installation

Add the DataParser package to your project using Swift Package Manager. In your `Package.swift` file, add the following dependency:

```swift
dependencies: [
    .package(url: "https://github.com/huiping192/DataParser.git", from: "0.0.2"),
]
```

And then add DataParser to your target dependencies:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["DataParser"]),
]
```

## Usage

```swift
import DataParser

// Create a parser
let parser = DataParser(start: "\t{", end: "}\n", bufferSize: 2048)

// Append data to the parser
parser.appendData("Some random data\n".data(using: .utf8)!)
parser.appendData("\t{\"key\":\"value\"}\nMore random data".data(using: .utf8)!)
parser.appendData("\t{\"key2\":\"value2\"}\n".data(using: .utf8)!)

// Process the data
if let firstDataResult = parser.processData() {
  let firstResult = String(data: firstDataResult, encoding: .utf8) // "\"key\":\"value\""
}

if let secondDataResult = parser.processData() {
  let secondResult = String(data: secondDataResult, encoding: .utf8) // "\"key2\":\"value2\""
}
```

For more examples and test cases, check out the DataParserTests file.

## Contributing

Contributions are welcome! Please submit a pull request or create an issue to discuss any changes or improvements you'd like to make.

## License

DataParser is released under the MIT License. See the LICENSE file for more information.


