import gleam/int
import gleam/io
import gleam/list
import gleam/result
import parsing/parsing

pub fn main() {
  let string_list = parsing.read("./input/day1")
  let blah = result.all(list.map(string_list, to_dial))
  let day1a =
    blah
    |> result.map(fn(dials) {
      calculate_number_of_dials_exactly_zero(dials, 50, 0)
    })
    |> result.unwrap(0)


  let day1b = blah
    |> result.map(fn(dials) {
      calculate_number_of_dials_past_zero(dials, 50, 0)
    })
    |> result.unwrap(0)

  io.println("Amount of times dialed to zero: " <> int.to_string(day1a))
  io.println("Amount of times dialed passed zero: " <> int.to_string(day1b))
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

pub fn calculate_number_of_dials_exactly_zero(
  dials: List(Dial),
  dial_position: Int,
  amount_of_zeroes: Int,
) -> Int {
  case dials {
    [] -> amount_of_zeroes
    [first, ..rest] -> {
      let new_position = turn_dial(first, dial_position)
      let new_amount_of_zeroes = case new_position {
        0 -> amount_of_zeroes + 1
        _ -> amount_of_zeroes
      }
      calculate_number_of_dials_exactly_zero(
        rest,
        new_position,
        new_amount_of_zeroes,
      )
    }
  }
}

pub fn calculate_number_of_dials_past_zero(
  dials: List(Dial),
  dial_position: Int,
  amount_of_zeroes: Int,
) -> Int {
  case dials {
    [] -> amount_of_zeroes
    [first, ..rest] -> {
      let amount_full_rotation = first.turn_amount / 100
      let crossed_zero = case first.direction {
        Left ->
          case dial_position - first.turn_amount % 100 < 0 && dial_position != 0 {
            True -> 1
            False -> 0
          }
        Right ->
          case dial_position + first.turn_amount % 100 > 100  {
            True -> 1
            False -> 0
          }
      }
      let new_position = turn_dial(first, dial_position)
      let new_amount_of_zeroes = case new_position {
        0 -> 1
        _ -> 0
      }
      calculate_number_of_dials_past_zero(
        rest,
        new_position,
        amount_of_zeroes  + new_amount_of_zeroes + amount_full_rotation + crossed_zero,
      )
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
    Right -> { position + dial.turn_amount } % 100
  }
}
