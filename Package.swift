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
      checksum: "d2d2802989ed6a9e641f68edf04e4724a6e86a25deb85bfbfb6715aad09b733e"),
  ]
)
