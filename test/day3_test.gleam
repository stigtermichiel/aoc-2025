import day3/day3
import gleeunit

pub fn main() {
  gleeunit.main()
}

pub fn can_find_highest_joltage_in_a_bank_test() {
  let bank: day3.Bank = ["6", "1", "5", "5", "1", "1", "7", "9", "6", "2", "4"]
  let banka: day3.Bank = ["8", "1", "5", "5", "1", "7", "4", "6", "2", "9"]
  assert day3.highest_voltage(bank) == 96
  assert day3.highest_voltage(banka) == 89
}

pub fn can_find_highest_joltage_in_a_bank_b_test() {
  let bank: day3.Bank = ["9", "8", "7", "6", "5", "4", "3", "2", "1", "1", "1", "1", "1", "1", "1"]
  let banka: day3.Bank = ["8", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "9"]
  let bankb: day3.Bank = ["2","3","4","2","3","4","2","3","4","2","3","4","2","7","8"]
  assert day3.highest_voltage_b(bank) == 987654321111
  assert day3.highest_voltage_b(banka) == 811111111119
  assert day3.highest_voltage_b(bankb) == 434234234278
}