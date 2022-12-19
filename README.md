# synpipe

Render `stdin` input with [`syntect`](https://github.com/trishume/syntect) as formatted HTML to `stdout`.

## Framework

https://betterprogramming.pub/from-rust-to-swift-df9bde59b7cd

```sh
cbindgen --lang c --output include/syntact.h

rustup target add aarch64-apple-ios
cargo build --release --target x86_64-apple-darwin
cargo build --release --target aarch64-apple-ios

codesign -a x86_64 -s "Apple Development: Bastiaan Van der Hoek (576HK37AL8)" -f target/x86_64-apple-darwin/release/libsyntact.a
codesign -a x86_64 -s "Apple Development: Bastiaan Van der Hoek (576HK37AL8)" -f target/aarch64-apple-ios/release/libsyntact.a

xcodebuild -create-xcframework \
  -library target/x86_64-apple-darwin/release/libsyntact.a \
  -headers ./include/ \
  -library ./target/aarch64-apple-ios/release/libsyntact.a \
  -headers ./include/ \
  -output SynTact.xcframework
```

https://stackoverflow.com/questions/60782402/calling-rust-from-swift

https://gregoryszorc.com/docs/apple-codesign/main/ zou code signing makkelijker maken.