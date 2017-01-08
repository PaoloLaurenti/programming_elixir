defmodule Chop do
  def guess(actual, first..last) do
    guess(actual, div(last - first + 1, 2), first..last)
  end

  def guess(actual, guessed, _) when actual == guessed do
    guessed
  end

  def guess(actual, guessed, first.._) when guessed > actual do
    IO.puts "Is it #{guessed}"
    guess(actual, guessed - div(guessed - first + 1, 2), first..guessed)
  end

  def guess(actual, guessed, _..last) when guessed < actual do
    IO.puts "Is it #{guessed}"
    guess(actual, guessed + div(last - guessed, 2), guessed..last)
  end
end
