SIGN_IDENTITY = "Apple Development: Bastiaan Van der Hoek (576HK37AL8)"

SynTact.xcframework: target/x86_64-apple-darwin/release/libsyntact.a
	xcodebuild -create-xcframework \
      -library target/x86_64-apple-darwin/release/libsyntact.a \
      -headers ./include/ \
      -output SynTact.xcframework

target/x86_64-apple-darwin/release/libsyntact.a: include/syntact.h
	cargo build --release --target x86_64-apple-darwin
	codesign -a x86_64 -s $(SIGN_IDENTITY) -f target/x86_64-apple-darwin/release/libsyntact.a

include/syntact.h: src/lib.rs
	cbindgen --lang c --output include/syntact.h

clean:
	rm -rf Syntact.xcframework