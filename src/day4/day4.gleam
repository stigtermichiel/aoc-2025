import gleam/list
import gleam/pair
import gleam/string
import parsing/parsing

pub fn main() {
  let grid =
    parsing.read("./input/day4", "\n")
    |> list.map(fn(s) { string.to_graphemes(s) })
    |> list.index_map(fn(graphemes, row_index) {
      list.index_map(graphemes, fn(char, col_index) {
        #(#(row_index, col_index), char)
      })
    })
    |> list.flatten

  //day4a
  grid
  |> list.fold(0, fn(acc, item) {
    case pair.first(item), pair.second(item) {
      position, char if char == "@" -> {
        case around_fewer_than_four_rolls(position, grid) {
          True -> acc + 1
          False -> acc
        }
      }
      _, _ -> acc
    }
  })
  |> echo

  //day4b
  count_rolls_removed(grid, 0)
  |> echo
}

pub fn count_rolls_removed(
  board: List(#(#(Int, Int), String)),
  rolls_removed: Int,
) -> Int {
  let new_grid = list.fold(board, #(0, []), fn(acc, item) {
    case pair.first(item), pair.second(item) {
      position, char if char == "@" -> {
        case around_fewer_than_four_rolls(position, board) {
          True -> #(pair.first(acc) + 1, list.append(pair.second(acc), [#(position, ".")]))
          False -> #(pair.first(acc), list.append(pair.second(acc), [item]))
        }
      }
      _, _ -> #(pair.first(acc), list.append(pair.second(acc), [item]))
    }
  })

  case pair.second(new_grid) == board {
    True -> rolls_removed
    False -> count_rolls_removed(pair.second(new_grid), rolls_removed + pair.first(new_grid))
  }

}

pub fn around_fewer_than_four_rolls(
  position: #(Int, Int),
  board: List(#(#(Int, Int), String)),
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
      case list.key_find(board, new_position) {
        Ok(roll) if roll == "@" -> True
        _ -> False
      }
    })
    |> list.length

  rolls < 4
}
