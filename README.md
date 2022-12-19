# synpipe

Render `stdin` input with [`syntect`](https://github.com/trishume/syntect) as formatted HTML to `stdout`.

## Framework

https://betterprogramming.pub/from-rust-to-swift-df9bde59b7cd

```sh
cargo build --release --target x86_64-apple-darwin
rustup target add aarch64-apple-ios
cargo build --release --target aarch64-apple-ios

xcodebuild -create-xcframework \
  -library target/x86_64-apple-darwin/release/libsyntact.a \
  -headers ./include/ \
  -library ./target/aarch64-apple-ios/release/libsyntact.a \
  -headers ./include/ \
  -output SynTact.xcframework
```