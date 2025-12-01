import gleam/list
import gleam/string
import simplifile

pub fn read(name: String) -> List(String) {
  case simplifile.read(name) {
    Ok(content) -> {
      list.filter(string.split(content, "\n"), fn(line) {
        line != ""
      })
    }
    Error(_) -> panic as string.concat(["error reading ", name])
  }
}