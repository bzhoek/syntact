# syntact

Render `stdin` input with [`syntect`](https://github.com/trishume/syntect) as formatted HTML to `stdout`.

## Building

Instructions for building a Rust XCFramework from https://betterprogramming.pub/from-rust-to-swift-df9bde59b7cd [automated](Makefile).

```sh
cbindgen --lang c --output include/syntact.h

rustup target add aarch64-apple-ios
cargo build --release --target x86_64-apple-darwin
cargo build --release --target aarch64-apple-ios

codesign -s "Apple Development: Bastiaan Van der Hoek (576HK37AL8)" -f target/x86_64-apple-darwin/release/libsyntact.a
codesign -s "Apple Development: Bastiaan Van der Hoek (576HK37AL8)" -f target/aarch64-apple-ios/release/libsyntact.a

codesign -d --verbose=2 target/aarch64-apple-ios/release/libsyntact.a # verify signatures

xcodebuild -create-xcframework \
  -library target/x86_64-apple-darwin/release/libsyntact.a \
  -headers ./include/ \
  -library ./target/aarch64-apple-ios/release/libsyntact.a \
  -headers ./include/ \
  -output Syntact.xcframework
```

## Sources
- https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html
- https://stackoverflow.com/questions/60782402/calling-rust-from-swift, doesn't work
- https://snacky.blog/en/string-ffi-rust.html does
- https://gregoryszorc.com/docs/apple-codesign/main/ should ease code signing
