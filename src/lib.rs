use std::ffi::{c_char, CString};

#[no_mangle]
pub extern "C" fn add(a: i32, b: i32) -> i32 {
  a + b
}

#[no_mangle]
// https://snacky.blog/en/string-ffi-rust.html
pub extern fn unicode_from_rust() -> *const c_char {
  let s = CString::new("Hello 😸").unwrap();
  let p = s.as_ptr();
  std::mem::forget(s);
  p
}