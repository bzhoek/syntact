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
    .target(
      name: "SyntaxKit",
      dependencies: ["Syntact"]
      ),
    .binaryTarget(
      name: "Syntact",
      path: "./Syntact.xcframework"
    )
  ]
)
