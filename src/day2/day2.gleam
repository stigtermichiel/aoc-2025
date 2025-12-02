import gleam/int
import gleam/io
import gleam/list
import gleam/string
import parsing/parsing

pub fn main() {
  let ranges =
    list.map(parsing.read("./input/day2", ","), fn(s) {
      let a = string.split(s, "-")
      case a {
        [start_str, end_str] -> {
          let start = int.parse(start_str)
          let end = int.parse(end_str)
          case start, end {
            Ok(s), Ok(e) -> IdRange(s, e)
            _, _ -> panic as "Invalid input"
          }
        }
        _ -> panic as "Invalid input"
      }
    })

  let day2_a =
    list.flatten(
      list.map(ranges, fn(range) {
        list.filter(list.range(range.start, range.end), fn(id) { !valid_id(id) })
      }),
    )

  let day2_b =
  list.flatten(
  list.map(ranges, fn(range) {
    list.filter(list.range(range.start, range.end), fn(id) { invalid_id_b(id) })
  }),
  )
  
  int.to_string(int.sum(day2_a))
  |> io.println()

  int.to_string(int.sum(day2_b))
  |> io.println()
}

pub type IdRange {
  IdRange(start: Int, end: Int)
}

pub fn valid_id(id: Int) -> Bool {
  let id_size = string.length(int.to_string(id))
  case id_size % 2 == 0 {
    False -> True
    True -> {
      let first_half = string.slice(int.to_string(id), 0, id_size / 2)
      let second_half = string.slice(int.to_string(id), id_size / 2, id_size)
      first_half != second_half
    }
  }
}

pub fn invalid_id_b(id: Int) -> Bool {
  let id_str = int.to_string(id)
  let id_size = string.length(id_str)

  list.any(list.range(1, id_size), fn(chunk_size) {
    let chunks: List(List(String)) =
      list.sized_chunk(string.to_graphemes(id_str), chunk_size)

    list.length(chunks) != 1 && list.length(list.unique(chunks)) == 1
  })
}
