import gleam/io
import gleam/result
import gleam/int
import gleam/list
import parsing/parsing

pub fn main() {
  let string_list = parsing.read("./input/day1")
  let b = result.all(list.map(string_list, to_dial(_)))
  |> result.map(fn(dials) {
    calculate_number_of_dials_zero(dials, 50, 0)
  })
  |> result.unwrap(0)

  io.println("Amount of times dialed to zero: " <> int.to_string(b))
}

fn to_dial(s: String) -> Result(Dial, Nil) {
  case s {
    "L" <> rest -> {
      let amount = int.parse(rest)
      case amount {
        Ok(num) -> Ok(Dial(Left, num))
        Error(a) -> Error(a)
      }
    }
    "R" <> rest -> {
      let amount = int.parse(rest)
      case amount {
        Ok(num) -> Ok(Dial(Right, num))
        Error(a) -> Error(a)
      }
    }
    _ -> Error(Nil)
  }
}

pub type Dial {
  Dial(direction: Direction, turn_amount: Int)
}

pub type Direction {
  Left
  Right
}

pub fn calculate_number_of_dials_zero(dials: List(Dial), dial_position: Int, amount_of_zeroes: Int) -> Int {
  case dials {
    [] -> amount_of_zeroes
    [first, ..rest] -> {
      let new_position = turn_dial(first, dial_position)
      let new_amount_of_zeroes = case new_position {
        0 -> amount_of_zeroes + 1
        _ -> amount_of_zeroes
      }
      calculate_number_of_dials_zero(rest, new_position, new_amount_of_zeroes)
    }
  }
}

pub fn turn_dial(dial: Dial, position: Int) -> Int {
  case dial.direction {
    Left -> {
      let new_position = position - dial.turn_amount % 100
      case new_position {
        a if new_position < 0 -> 100 + a
        _ -> new_position
      }
    }
    Right -> {position + dial.turn_amount} % 100
  }
}
