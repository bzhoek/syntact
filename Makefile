SIGN_IDENTITY = "Apple Development: Bastiaan Van der Hoek (576HK37AL8)"

Syntact.xcframework: target/libsyntact_macos.a target/aarch64-apple-ios/release/libsyntact.a target/x86_64-apple-ios/release/libsyntact.a
	xcodebuild -create-xcframework \
      -library target/libsyntact_macos.a \
      -headers ./include/ \
      -library target/aarch64-apple-ios/release/libsyntact.a \
      -headers ./include/ \
      -library target/x86_64-apple-ios/release/libsyntact.a \
      -headers ./include/ \
      -output Syntact.xcframework
	zip -r bundle.zip Syntact.xcframework
	openssl dgst -sha256 bundle.zip

define lipo_sign
    echo $2
	lipo -create -output $2 $1
	codesign -s $(SIGN_IDENTITY) -f $2
endef

target/libsyntact_macos.a: target/x86_64-apple-darwin/release/libsyntact.a target/aarch64-apple-darwin/release/libsyntact.a
	$(call lipo_sign,$^,$@)

target/aarch64-apple-ios/release/libsyntact.a: include/syntact.h
	cargo build --release --target aarch64-apple-ios

target/x86_64-apple-ios/release/libsyntact.a: include/syntact.h
	cargo build --release --target x86_64-apple-ios

target/x86_64-apple-darwin/release/libsyntact.a: include/syntact.h
	cargo build --release --target x86_64-apple-darwin

target/aarch64-apple-darwin/release/libsyntact.a: include/syntact.h
	cargo build --release --target aarch64-apple-darwin

include/syntact.h: src/lib.rs
	cbindgen --lang c --output include/syntact.h

clean:
	rm -rf Syntact.xcframework
	rm include/syntact.h
	rm target/*.a
