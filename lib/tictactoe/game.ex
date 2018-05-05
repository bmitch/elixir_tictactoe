defmodule Tictactoe.Game do

  alias Tictactoe.Game


  defstruct(
    game_state: :initializing,
    board: {nil, nil, nil, nil, nil, nil, nil, nil, nil},
    whos_turn: :x
  )

  def new_game() do
    %Tictactoe.Game{}
  end

  def make_move(game = %Game{ whos_turn: who}, who, x, y)  do
    index = convert_to_tuple_index(x, y)
    accept_move(game, who, index, tuple_nil_at(game.board, index))
  end

  def make_move(game = %Game{}, _invalid, _x, _y) do
    Map.put(game, :game_state, :invalid_player)
  end

  defp convert_to_tuple_index(x, y) do
    y * 3 + x
  end

  defp tuple_nil_at(tuple, index) do
    nil == elem(tuple, index)
  end

  defp accept_move(game = %Game{}, who, index, true) do
    new_board = game.board |> put_elem(index, who)
    game = Map.put(game, :board, new_board)
    |> Map.put(:whos_turn, rotate_player(who))
    game_state = update_game_state(game)
    Map.put(game, :game_state, game_state)
  end

  defp accept_move(game = %Game{}, who, index, _false) do
    Map.put(game, :game_state, :already_used)
  end

  defp rotate_player(:x), do: :o
  defp rotate_player(:o), do: :x

  defp update_game_state(game = %Game{}) do
    check_board(game.board)
  end

  defp check_board({:x, :x, :x, nil, nil, nil, :o, :o, nil}) do
    :xwins
  end

  defp check_board(_dontmatter) do
    :in_progress
  end

end
