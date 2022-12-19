SIGN_IDENTITY = "Apple Development: Bastiaan Van der Hoek (576HK37AL8)"

SynTact.xcframework: target/libsyntact_macos.a
	xcodebuild -create-xcframework \
      -library target/libsyntact_macos.a \
      -headers ./include/ \
      -output SynTact.xcframework

target/libsyntact_macos.a: target/x86_64-apple-darwin/release/libsyntact.a
	lipo -create target/x86_64-apple-darwin/release/libsyntact.a \
	  -output target/libsyntact_macos.a
	codesign -a x86_64 -s $(SIGN_IDENTITY) -f target/libsyntact_macos.a

target/x86_64-apple-darwin/release/libsyntact.a: include/syntact.h
	cargo build --release --target x86_64-apple-darwin

include/syntact.h: src/lib.rs
	cbindgen --lang c --output include/syntact.h

clean:
	rm -rf Syntact.xcframework
	rm include/syntact.h