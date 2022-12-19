use std::ffi::{c_char, CStr, CString};

use syntect::easy::HighlightLines;
use syntect::highlighting::ThemeSet;
use syntect::html::{append_highlighted_html_for_styled_line, IncludeBackground};
use syntect::parsing::SyntaxSet;
use syntect::util::LinesWithEndings;

#[no_mangle]
pub extern "C" fn add(a: i32, b: i32) -> i32 {
  a + b
}

#[no_mangle]
// https://snacky.blog/en/string-ffi-rust.html
pub extern fn unicode_from_rust() -> *const c_char {
  let cstring = CString::new("Hello 😸").unwrap();
  let p = cstring.as_ptr();
  std::mem::forget(cstring);
  p
}

#[no_mangle]
// https://snacky.blog/en/string-ffi-rust.html
pub unsafe extern "C" fn highlighter(source: *const std::os::raw::c_char, extension: *const std::os::raw::c_char) -> *const c_char {
  let source = CStr::from_ptr(source);
  let extension = CStr::from_ptr(extension);
  let result = highlight(source.to_str().unwrap(), extension.to_str().unwrap());
  let cstring = CString::new(result).unwrap();
  let p = cstring.as_ptr();
  std::mem::forget(cstring);
  p
}

pub fn highlight(source: &str, extension: &str) -> String {
  let syntaxes = SyntaxSet::load_defaults_newlines();
  let syntax = syntaxes.find_syntax_by_extension(extension)
    .unwrap_or(syntaxes.find_syntax_plain_text());

  let themes = ThemeSet::load_defaults();
  let theme = &themes.themes["base16-ocean.dark"];

  let mut highlighter = HighlightLines::new(syntax, theme);
  let mut output = "<pre>".to_string();

  for line in LinesWithEndings::from(&*source) {
    let regions = highlighter.highlight_line(line, &syntaxes).unwrap();
    append_highlighted_html_for_styled_line(
      &regions[..],
      IncludeBackground::No,
      &mut output,
    ).unwrap();
  }

  output.push_str("</pre>");
  output
}
