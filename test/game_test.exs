defmodule GameTest do
  use ExUnit.Case

  alias Tictactoe.Game

  test "new_game returns structure" do
    game = Game.new_game()

    assert game.whos_turn == :x
    assert game.game_state == :initializing
    assert game.board == {nil, nil, nil, nil, nil, nil, nil, nil, nil}
  end

  test "after the first move is made the game_state is set to :in_progress" do
    game = Game.new_game()
    game = Tictactoe.make_move(game, :x, 0, 0)
    assert game.game_state == :in_progress
  end

  test "x can make the first move and then whos_turn changes to o and so on" do
    game = Game.new_game()
    assert game.whos_turn == :x
    game = Tictactoe.make_move(game, :x, 0, 0)
    assert game.whos_turn == :o
    game = Tictactoe.make_move(game, :o, 0, 1)
    assert game.whos_turn == :x
    game = Tictactoe.make_move(game, :x, 0, 2)
    assert game.whos_turn == :o
  end

  test "if you try and play an occupied spot it fails and state is :already_used" do
    game = Game.new_game()
    game = Tictactoe.make_move(game, :x, 0, 0)
    game = Tictactoe.make_move(game, :o, 0, 0)
    assert game.game_state == :already_used
    assert game.board == {:x, nil, nil, nil, nil, nil, nil, nil, nil}
  end

  test "if o tries to make the first move the game state is :invalid_player" do
    game = Game.new_game()
    game = Tictactoe.make_move(game, :o, 0, 0)
    assert game.game_state == :invalid_player
    assert game.board == {nil, nil, nil, nil, nil, nil, nil, nil, nil}
  end

  test "if x or o is not the whos_turn player and makes a move then the game state is :invalid_player" do
    game = Game.new_game()
    game = Tictactoe.make_move(game, :o, 0, 0)
    assert game.game_state == :invalid_player
    game = Tictactoe.make_move(game, :x, 0, 0)
    game = Tictactoe.make_move(game, :x, 1, 0)
    assert game.game_state == :invalid_player
    game = Tictactoe.make_move(game, :o, 1, 0)
    game = Tictactoe.make_move(game, :o, 0, 1)
    assert game.game_state == :invalid_player
    assert game.board == {:x, :o, nil, nil, nil, nil, nil, nil, nil}
  end

  test "if a player other than x or o tries to make a move the state is :invalid_player" do
    game = Game.new_game()
    game = Tictactoe.make_move(game, :z, 0, 0)
    assert game.game_state == :invalid_player
    assert game.board == {nil, nil, nil, nil, nil, nil, nil, nil, nil}

    game = Tictactoe.make_move(game, :b, 0, 0)
    assert game.game_state == :invalid_player
    assert game.board == {nil, nil, nil, nil, nil, nil, nil, nil, nil}
  end

  test "if :x gets the the top row then :x wins" do
    game = Game.new_game()
    game = Tictactoe.make_move(game, :x, 0, 0)
    game = Tictactoe.make_move(game, :o, 0, 2)
    game = Tictactoe.make_move(game, :x, 1, 0)
    game = Tictactoe.make_move(game, :o, 1, 2)
    game = Tictactoe.make_move(game, :x, 2, 0)
    assert game.board == {:x, :x, :x, nil, nil, nil, :o, :o, nil}
    assert game.game_state == :x_wins
  end

  test "if :o gets the the top row then :o wins" do
    game = Game.new_game()
    game = Tictactoe.make_move(game, :x, 0, 2)
    game = Tictactoe.make_move(game, :o, 0, 0)
    game = Tictactoe.make_move(game, :x, 1, 2)
    game = Tictactoe.make_move(game, :o, 1, 0)
    game = Tictactoe.make_move(game, :x, 0, 1)
    game = Tictactoe.make_move(game, :o, 2, 0)
    assert game.board == {:o, :o, :o, :x, nil, nil, :x, :x, nil}
    assert game.game_state == :o_wins
  end

  test "if :x gets the the middle row then :x wins" do
    game = Game.new_game()
    game = Tictactoe.make_move(game, :x, 0, 1)
    game = Tictactoe.make_move(game, :o, 0, 2)
    game = Tictactoe.make_move(game, :x, 1, 1)
    game = Tictactoe.make_move(game, :o, 1, 2)
    game = Tictactoe.make_move(game, :x, 2, 1)
    assert game.board == {nil, nil, nil, :x, :x, :x, :o, :o, nil}
    assert game.game_state == :x_wins
  end

  test "if :o gets the the middle row then :o wins" do
    game = Game.new_game()
    game = Tictactoe.make_move(game, :x, 0, 2)
    game = Tictactoe.make_move(game, :o, 0, 1)
    game = Tictactoe.make_move(game, :x, 1, 2)
    game = Tictactoe.make_move(game, :o, 1, 1)
    game = Tictactoe.make_move(game, :x, 0, 0)
    game = Tictactoe.make_move(game, :o, 2, 1)
    assert game.board == {:x, nil, nil, :o, :o, :o, :x, :x, nil}
    assert game.game_state == :o_wins
  end

  test "if :x gets the the bottom row then :x wins" do
    game = Game.new_game()
    game = Tictactoe.make_move(game, :x, 0, 2)
    game = Tictactoe.make_move(game, :o, 0, 1)
    game = Tictactoe.make_move(game, :x, 1, 2)
    game = Tictactoe.make_move(game, :o, 1, 1)
    game = Tictactoe.make_move(game, :x, 2, 2)
    assert game.board == {nil, nil, nil, :o, :o, nil, :x, :x, :x}
    assert game.game_state == :x_wins
  end

  test "if :o gets the the bottom row then :o wins" do
    game = Game.new_game()
    game = Tictactoe.make_move(game, :x, 0, 1)
    game = Tictactoe.make_move(game, :o, 0, 2)
    game = Tictactoe.make_move(game, :x, 1, 1)
    game = Tictactoe.make_move(game, :o, 1, 2)
    game = Tictactoe.make_move(game, :x, 0, 0)
    game = Tictactoe.make_move(game, :o, 2, 2)
    assert game.board == {:x, nil, nil, :x, :x, nil, :o, :o, :o}
    assert game.game_state == :o_wins
  end

  test "if :x gets the the left col then :x wins" do
    game = Game.new_game()
    game = Tictactoe.make_move(game, :x, 0, 0)
    game = Tictactoe.make_move(game, :o, 1, 1)
    game = Tictactoe.make_move(game, :x, 0, 1)
    game = Tictactoe.make_move(game, :o, 2, 1)
    game = Tictactoe.make_move(game, :x, 0, 2)
    assert game.board == {:x, nil, nil, :x, :o, :o, :x, nil, nil}
    assert game.game_state == :x_wins
  end

  test "if :o gets the the left col then :o wins" do
    game = Game.new_game()
    game = Tictactoe.make_move(game, :x, 1, 1)
    game = Tictactoe.make_move(game, :o, 0, 0)
    game = Tictactoe.make_move(game, :x, 2, 1)
    game = Tictactoe.make_move(game, :o, 0, 1)
    game = Tictactoe.make_move(game, :x, 1, 0)
    game = Tictactoe.make_move(game, :o, 0, 2)
    assert game.board == {:o, :x, nil, :o, :x, :x, :o, nil, nil}
    assert game.game_state == :o_wins
  end

  test "if :x gets the the middle col then :x wins" do
    game = Game.new_game()
    game = Tictactoe.make_move(game, :x, 1, 0)
    game = Tictactoe.make_move(game, :o, 0, 0)
    game = Tictactoe.make_move(game, :x, 1, 1)
    game = Tictactoe.make_move(game, :o, 2, 0)
    game = Tictactoe.make_move(game, :x, 1, 2)
    assert game.board == {:o, :x, :o, nil, :x, nil, nil, :x, nil}
    assert game.game_state == :x_wins
  end

  test "if :o gets the the middle col then :o wins" do
    game = Game.new_game()
    game = Tictactoe.make_move(game, :x, 0, 0)
    game = Tictactoe.make_move(game, :o, 1, 0)
    game = Tictactoe.make_move(game, :x, 2, 0)
    game = Tictactoe.make_move(game, :o, 1, 1)
    game = Tictactoe.make_move(game, :x, 0, 1)
    game = Tictactoe.make_move(game, :o, 1, 2)
    assert game.board == {:x, :o, :x, :x, :o, nil, nil, :o, nil}
    assert game.game_state == :o_wins
  end

  test "if :x gets the the right col then :x wins" do
    game = Game.new_game()
    game = Tictactoe.make_move(game, :x, 2, 0)
    game = Tictactoe.make_move(game, :o, 0, 0)
    game = Tictactoe.make_move(game, :x, 2, 1)
    game = Tictactoe.make_move(game, :o, 1, 0)
    game = Tictactoe.make_move(game, :x, 2, 2)
    assert game.board == {:o, :o, :x, nil, nil, :x, nil, nil, :x}
    assert game.game_state == :x_wins
  end

  test "if :o gets the the right col then :o wins" do
    game = Game.new_game()
    game = Tictactoe.make_move(game, :x, 0, 0)
    game = Tictactoe.make_move(game, :o, 2, 0)
    game = Tictactoe.make_move(game, :x, 1, 0)
    game = Tictactoe.make_move(game, :o, 2, 1)
    game = Tictactoe.make_move(game, :x, 1, 2)
    game = Tictactoe.make_move(game, :o, 2, 2)
    assert game.board == {:x, :x, :o, nil, nil, :o, nil, :x, :o}
    assert game.game_state == :o_wins
  end

  test "if :x gets diagnoal going down then :x wins" do
    game = Game.new_game()
    game = Tictactoe.make_move(game, :x, 0, 0)
    game = Tictactoe.make_move(game, :o, 1, 0)
    game = Tictactoe.make_move(game, :x, 1, 1)
    game = Tictactoe.make_move(game, :o, 2, 0)
    game = Tictactoe.make_move(game, :x, 2, 2)
    assert game.board == {:x, :o, :o, nil, :x, nil, nil, nil, :x}
    assert game.game_state == :x_wins
  end

  test "if :o gets diagnoal going down then :o wins" do
    game = Game.new_game()
    game = Tictactoe.make_move(game, :x, 1, 0)
    game = Tictactoe.make_move(game, :o, 0, 0)
    game = Tictactoe.make_move(game, :x, 2, 0)
    game = Tictactoe.make_move(game, :o, 1, 1)
    game = Tictactoe.make_move(game, :x, 0, 1)
    game = Tictactoe.make_move(game, :o, 2, 2)
    assert game.board == {:o, :x, :x, :x, :o, nil, nil, nil, :o}
    assert game.game_state == :o_wins
  end

  test "if :x gets diagnoal going up then :x wins" do
    game = Game.new_game()
    game = Tictactoe.make_move(game, :x, 2, 0)
    game = Tictactoe.make_move(game, :o, 0, 0)
    game = Tictactoe.make_move(game, :x, 1, 1)
    game = Tictactoe.make_move(game, :o, 1, 0)
    game = Tictactoe.make_move(game, :x, 0, 2)
    assert game.board == {:o, :o, :x, nil, :x, nil, :x, nil, nil}
    assert game.game_state == :x_wins
  end

  test "if :o gets diagnoal going up then :o wins" do
    game = Game.new_game()
    game = Tictactoe.make_move(game, :x, 0, 0)
    game = Tictactoe.make_move(game, :o, 2, 0)
    game = Tictactoe.make_move(game, :x, 1, 0)
    game = Tictactoe.make_move(game, :o, 1, 1)
    game = Tictactoe.make_move(game, :x, 0, 1)
    game = Tictactoe.make_move(game, :o, 0, 2)
    assert game.board == {:x, :x, :o, :x, :o, nil, :o, nil, nil}
    assert game.game_state == :o_wins
  end

  test "the board can be filled up and results in a draw" do
    game = Game.new_game()
    game = Tictactoe.make_move(game, :x, 0, 0)

    assert game.board == {
             :x,
             nil,
             nil,
             nil,
             nil,
             nil,
             nil,
             nil,
             nil
           }

    game = Tictactoe.make_move(game, :o, 1, 0)

    assert game.board == {
             :x,
             :o,
             nil,
             nil,
             nil,
             nil,
             nil,
             nil,
             nil
           }

    game = Tictactoe.make_move(game, :x, 2, 0)

    assert game.board == {
             :x,
             :o,
             :x,
             nil,
             nil,
             nil,
             nil,
             nil,
             nil
           }

    game = Tictactoe.make_move(game, :o, 1, 1)

    assert game.board == {
             :x,
             :o,
             :x,
             nil,
             :o,
             nil,
             nil,
             nil,
             nil
           }

    game = Tictactoe.make_move(game, :x, 0, 1)

    assert game.board == {
             :x,
             :o,
             :x,
             :x,
             :o,
             nil,
             nil,
             nil,
             nil
           }

    game = Tictactoe.make_move(game, :o, 0, 2)

    assert game.board == {
             :x,
             :o,
             :x,
             :x,
             :o,
             nil,
             :o,
             nil,
             nil
           }

    game = Tictactoe.make_move(game, :x, 1, 2)

    assert game.board == {
             :x,
             :o,
             :x,
             :x,
             :o,
             nil,
             :o,
             :x,
             nil
           }

    game = Tictactoe.make_move(game, :o, 2, 2)

    assert game.board == {
             :x,
             :o,
             :x,
             :x,
             :o,
             nil,
             :o,
             :x,
             :o
           }

    game = Tictactoe.make_move(game, :x, 2, 1)

    assert game.board == {
             :x,
             :o,
             :x,
             :x,
             :o,
             :x,
             :o,
             :x,
             :o
           }

    assert game.game_state == :draw
  end
end
