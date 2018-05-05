defmodule Tictactoe.BoardChecker do

  def check_board({:x, :x, :x, _, _, _, _, _, _}), do: :x_wins
  def check_board({_, _, _, :x, :x, :x, _, _, _}), do: :x_wins
  def check_board({_, _, _, _, _, _, :x, :x, :x}), do: :x_wins
  def check_board({:x, _, _, :x, _, _, :x, _, _}), do: :x_wins
  def check_board({_, :x, _, _, :x, _, _, :x, _}), do: :x_wins
  def check_board({_, _, :x, _, _, :x, _, _, :x}), do: :x_wins
  def check_board({:x, _, _, _, :x, _, _, _, :x}), do: :x_wins
  def check_board({_, _, :x, _, :x, _, :x, _, _}), do: :x_wins
  def check_board({:o, :o, :o, _, _, _, _, _, _}), do: :o_wins
  def check_board({_, _, _, :o, :o, :o, _, _, _}), do: :o_wins
  def check_board({_, _, _, _, _, _, :o, :o, :o}), do: :o_wins
  def check_board({:o, _, _, :o, _, _, :o, _, _}), do: :o_wins
  def check_board({_, :o, _, _, :o, _, _, :o, _}), do: :o_wins
  def check_board({_, _, :o, _, _, :o, _, _, :o}), do: :o_wins
  def check_board({:o, _, _, _, :o, _, _, _, :o}), do: :o_wins
  def check_board({_, _, :o, _, :o, _, :o, _, _}), do: :o_wins
  def check_board({a, b, c, d, e, f, g, h, i}) when
    a != nil and b != nil and c != nil and d != nil and e != nil and f != nil and g != nil and h != nil and i != nil do
    :draw
  end
  def check_board(_dontmatter), do: :in_progress

end
