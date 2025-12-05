import gleam/int
import gleam/list
import gleam/pair
import gleam/result
import gleam/string
import parsing/parsing

pub fn main() {
  echo parsing.read("./input/day3", "\n")
    |> list.map(fn(x) { string.to_graphemes(x) })
    |> list.map(fn(a) { highest_voltage(a) })
    |> int.sum

  echo parsing.read("./input/day3", "\n")
  |> list.map(fn(x) { string.to_graphemes(x) })
  |> list.map(fn(a) { highest_voltage_b(a) })
  |> int.sum
}

pub fn highest_voltage(bank: Bank) -> Int {
  list.combination_pairs(bank)
  |> list.map(fn(p) {
    case int.parse(string.concat([pair.first(p), pair.second(p)])) {
      Ok(num) -> num
      Error(_) -> panic
    }
  })
  |> list.max(int.compare)
  |> result.unwrap(0)
}

pub fn highest_voltage_b(bank: Bank) -> Int {
  let b =
    list.map(bank, fn(x) {
      let s = int.parse(x)
      case s {
        Ok(num) -> num
        Error(_) -> panic
      }
    })

  loop(b, 12, "")
}

fn loop(bank: List(Int), room_needed: Int, highest: String) -> Int {
  case room_needed == 0 {
    True -> {
      let num = int.parse(highest)
      case num {
        Ok(n) -> n
        Error(_) -> panic
      }
    }
    False -> {
      let search_until = list.length(bank) - room_needed + 1
      let highest_num = list.index_fold(bank, #(0, 0), fn(acc, num, index) {
        case index < search_until && num > pair.first(acc) {
          True -> {
            #(num, index)
          }
          False -> acc
        }
      })
      loop(list.drop(bank, pair.second(highest_num) + 1), room_needed - 1, string.concat([highest, int.to_string(pair.first(highest_num))]))
    }
  }
}

pub type Bank =
  List(String)
