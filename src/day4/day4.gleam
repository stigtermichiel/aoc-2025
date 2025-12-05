import gleam/dict
import gleam/list
import gleam/pair
import gleam/string
import parsing/parsing

pub fn main() {
  let grid: Grid =
    parsing.read("./input/day4", "\n")
    |> list.map(fn(s) { string.to_graphemes(s) })
    |> list.index_map(fn(graphemes, row_index) {
      list.index_map(graphemes, fn(char, col_index) {
      #(#(row_index, col_index), char)
      })
    })
    |> list.flatten
    |> dict.from_list

  //day4a
  grid
  |> dict.fold(0, fn(acc, pos, cell) {
    case cell == "@" {
      True -> {
        case around_fewer_than_four_rolls(pos, grid) {
          True -> acc + 1
          False -> acc
        }
      }
      _ -> acc
    }
  })
  |> echo

  //day4b
  count_rolls_removed(grid, 0)
  |> echo
}

pub fn count_rolls_removed(
  board: Grid,
  rolls_removed: Int,
) -> Int {
  let gr = dict.fold(board, #(0, board), fn(acc, position, item) {
    case item == "@" && around_fewer_than_four_rolls(position, board) {
      True -> #(pair.first(acc) + 1, dict.insert(pair.second(acc), position, "."))
      False -> acc
    }
  })

  case pair.first(gr) == 0 {
    True -> rolls_removed
    False -> count_rolls_removed(pair.second(gr), rolls_removed + pair.first(gr))
  }

}

pub fn around_fewer_than_four_rolls(
  position: #(Int, Int),
  board: Grid,
) -> Bool {
  let deltas = [
    #(-1, 0),
    #(1, 0),
    #(0, -1),
    #(0, 1),
    #(-1, -1),
    #(-1, 1),
    #(1, -1),
    #(1, 1),
  ]

  let rolls =
    list.filter(deltas, fn(delta) {
      let new_position = #(
        pair.first(position) + pair.first(delta),
        pair.second(position) + pair.second(delta),
      )
      case dict.get(board, new_position) {
        Ok(item) if item == "@" -> True
        _ -> False
      }
    })
    |> list.length

  rolls < 4
}

pub type Grid = dict.Dict(#(Int, Int), String)
