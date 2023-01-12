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
      checksum: "cf682ee367c844983319be6c658a90300324bbbaa20a0632d2312c3adab77b0e"),
  ]
)
