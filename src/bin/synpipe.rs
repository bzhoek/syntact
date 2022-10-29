use std::io;
use std::io::Read;

use clap::{App, Arg};
use syntect::easy::HighlightFile;
use syntect::highlighting::ThemeSet;
use syntect::html::highlighted_html_for_string;
use syntect::html::IncludeBackground::No;
use syntect::parsing::SyntaxSet;

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

  let html = highlighted_html_for_string(&*string, &syntaxes, syntax, &theme).unwrap();
  print!("{}", html.replace(r#"<pre style="background-color:#2b303b;">"#, "<pre>"));
}
