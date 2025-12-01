import gleam/io

pub fn main() {
  io.println("Hello from vars!")
}

pub type Dial {
  Dial(direction: Direction, turn_amount: Int)
}

pub type Direction {
  Left
  Right
}

pub fn turn_dial(dial: Dial, position: Int) -> Int {
  case dial.direction {
    Left -> {
      let new_position = position - dial.turn_amount
      case new_position {
        a if new_position < 0 -> 100 + a
        _ -> new_position
      }
    }
    Right -> {
      let new_position = position + dial.turn_amount
      case new_position {
        a if new_position > 100 -> a - 100
        _ -> new_position
      }
    }
  }
}
