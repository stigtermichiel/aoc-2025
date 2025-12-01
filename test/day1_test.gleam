import day1/day1
import gleeunit

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

pub fn turn_dial_right_when_really_big_test() {
  let dial = day1.Dial(day1.Right, 400)
  let a = day1.turn_dial(dial, 50)
  assert a == 50

  let dial_left = day1.Dial(day1.Left, 400)
  let b = day1.turn_dial(dial_left, 50)
  assert b == 50
}

pub fn calculate_number_of_dials_zero_test() {
  let dials = [
    day1.Dial(day1.Left, 68),
    day1.Dial(day1.Left, 30),
    day1.Dial(day1.Right, 48),
    day1.Dial(day1.Left, 5),
    day1.Dial(day1.Right, 60),
    day1.Dial(day1.Left, 55),
    day1.Dial(day1.Left, 1),
    day1.Dial(day1.Left, 99),
    day1.Dial(day1.Right, 14),
    day1.Dial(day1.Left, 82),
  ]

  let amount_of_zeroes = day1.calculate_number_of_dials_zero(dials, 50, 0)

  assert amount_of_zeroes == 3
}


