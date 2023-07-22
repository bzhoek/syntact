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
      checksum: "5227335d29a27dbaba6a656cb9557d4cec5c68f47207bd0dc0b3b48a39bc937a"),
  ]
)
