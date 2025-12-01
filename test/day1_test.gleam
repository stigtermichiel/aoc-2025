// in test/vars_test.gleam
import gleeunit
import day1/day1

pub fn main() {
  gleeunit.main()
}

pub fn turn_dial_right_test() {
  let dial = day1.Dial(day1.Right, 10)
  let a = day1.turn_dial(dial, 50)
  assert a == 60
}

pub fn turn_dial_left_test() {
  let dial = day1.Dial(day1.Left, 10)
  let a = day1.turn_dial(dial, 50)
  assert a == 40
}

pub fn turn_dial_left_when_back_to_zero_test() {
  let dial = day1.Dial(day1.Left, 60)
  let a = day1.turn_dial(dial, 50)
  assert a == 90
}

pub fn turn_dial_right_when_back_to_zero_test() {
  let dial = day1.Dial(day1.Right, 60)
  let a = day1.turn_dial(dial, 50)
  assert a == 10
}
