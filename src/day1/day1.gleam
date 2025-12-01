import gleam/io

pub fn main() {
  io.println("Hello from vars!")
}

pub type Dial {
  Dial(direction: Direction, position: Int)
}

pub type Direction {
  Left
  Right
}

pub fn turn_dial(dial: Dial, position: Int) -> Int {
  case dial {
    Dial(direction, turn_amount) ->
    case direction {
      Left -> position - turn_amount
      Right -> position + turn_amount
    }
  }
}