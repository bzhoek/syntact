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
      checksum: "48652d318fe7996d22951c726bccd350fd2e42a115b70454da90a22e7272e4e5"),
  ]
)
