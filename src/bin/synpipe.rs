use std::io;
use std::io::{Read, Write};

use clap::{App, Arg};
use syntect::easy::HighlightLines;
use syntect::highlighting::ThemeSet;
use syntect::html::{append_highlighted_html_for_styled_line, IncludeBackground};
use syntect::parsing::SyntaxSet;
use syntect::util::LinesWithEndings;

fn main() {
  let args = App::new("synpipe")
    .arg(Arg::with_name("EXTENSION")
      .help("Syntax for extension")
      .short("x")
      .takes_value(true)
      .required(true))
    .get_matches();

  let extension = args.value_of("EXTENSION").unwrap();

  let mut string = String::new();
  let mut handle = io::stdin().lock();
  handle.read_to_string(&mut string).unwrap();

  let syntaxes = SyntaxSet::load_defaults_newlines();
  let syntax = syntaxes.find_syntax_by_extension(extension)
    .expect(&*format!("Unsupported extension type '{}'", extension));

  let themes = ThemeSet::load_defaults();
  let theme = &themes.themes["base16-ocean.dark"];

  let mut highlighter = HighlightLines::new(syntax, theme);
  let mut output = "<pre>".to_string();

  for line in LinesWithEndings::from(&*string) {
    let regions = highlighter.highlight_line(line, &syntaxes).unwrap();
    append_highlighted_html_for_styled_line(
      &regions[..],
      IncludeBackground::No,
      &mut output,
    ).unwrap();
  }

  output.push_str("</pre>");
  io::stdout().write_all(output.as_ref()).unwrap();
}
