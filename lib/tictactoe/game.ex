defmodule Tictactoe.Game do
  alias __MODULE__
  alias Tictactoe.BoardChecker

  defstruct(
    game_state: :initializing,
    board: {nil, nil, nil, nil, nil, nil, nil, nil, nil},
    whos_turn: :x
  )

  def new_game(), do: %Game{}

  def make_move(game = %Game{whos_turn: who}, who, x, y) do
    index = convert_to_tuple_index(x, y)
    accept_move(game, who, index, tuple_nil_at(game.board, index))
  end

  def make_move(game = %Game{}, _invalid, _x, _y) do
    Map.put(game, :game_state, :invalid_player)
  end

  defp convert_to_tuple_index(x, y), do: y * 3 + x

  defp tuple_nil_at(tuple, index), do: nil == elem(tuple, index)

  defp accept_move(game = %Game{}, who, index, true) do
    new_board = game.board |> put_elem(index, who)

    game =
      Map.put(game, :board, new_board)
      |> Map.put(:whos_turn, rotate_player(who))

    Map.put(game, :game_state, update_game_state(game))
  end

  defp accept_move(game = %Game{}, who, index, _false) do
    Map.put(game, :game_state, :already_used)
  end

  defp rotate_player(:x), do: :o
  defp rotate_player(:o), do: :x

  defp update_game_state(game = %Game{}), do: BoardChecker.check_board(game.board)
end
