// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "SyntaxKit",
  platforms: [
    .macOS(.v10_15),
    .iOS(.v12)
  ],
  products: [
    .library(name: "SyntaxKit", targets: ["SyntaxKit"]),
  ],
  targets: [
    .target(name: "SyntaxKit",
      dependencies: ["Syntact"]
      ),
    .binaryTarget(name: "Syntact",
      url: "https://github.com/bzhoek/syntact/raw/master/bundle.zip",
      checksum: "f7902525f698504200e1854339f5dd806525dfb8da9089fa115b4a531a5ed8f4"),
  ]
)
