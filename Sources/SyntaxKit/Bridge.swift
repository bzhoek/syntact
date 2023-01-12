import Foundation
import Syntact

func fenced_to_html(text: String, syntax: String) throws -> Data? {
  guard let cstr = highlighter(text, syntax) else { return nil }
  let string = String(cString: cstr)
  return string.data(using: .utf8)
}
