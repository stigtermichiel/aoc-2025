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
        Cell(#(row_index, col_index), char)
      })
    })
    |> list.flatten

  //day4a
  grid
  |> list.fold(0, fn(acc, cell) {
    case cell {
      Cell(pos, char) if char == "@" -> {
        case around_fewer_than_four_rolls(pos, grid) {
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
  board: Grid,
  rolls_removed: Int,
) -> Int {
  let new_grid = list.fold(board, #(0, []), fn(acc, cell) {
    case cell {
      Cell(position, char) if char == "@" -> {
        case around_fewer_than_four_rolls(position, board) {
          True -> #(pair.first(acc) + 1, list.append(pair.second(acc), [Cell(position, ".")]))
          False -> #(pair.first(acc), list.append(pair.second(acc), [cell]))
        }
      }
      _, _ -> #(pair.first(acc), list.append(pair.second(acc), [cell]))
    }
  })

  case pair.second(new_grid) == board {
    True -> rolls_removed
    False -> count_rolls_removed(pair.second(new_grid), rolls_removed + pair.first(new_grid))
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
      case list.find(board, fn(pos) {new_position == pos.position}) {
        Ok(cell) if cell.item == "@" -> True
        _ -> False
      }
    })
    |> list.length

  rolls < 4
}

pub type Cell{
  Cell(position: #(Int, Int), item: String)
}

pub type Grid = List(Cell)
