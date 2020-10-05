defmodule BankTest do
  use ExUnit.Case
  doctest Bank

  test "greets the world" do
    assert Bank.hello() == :world
  end
end
