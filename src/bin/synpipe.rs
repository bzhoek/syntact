use std::io;
use std::io::{Read, Write};

use clap::{App, Arg};

use syntact::highlight;

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

  let result = highlight(&*string, extension);

  io::stdout().write_all(result.as_ref()).unwrap();
}

