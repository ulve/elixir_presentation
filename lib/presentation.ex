defmodule Presentation do
  @moduledoc """
  Documentation for Presentation.
  """

  def present(presentation) do
    Enum.each(presentation, fn slide ->
      home()
      present_slide(slide)
    end)
  end

  def present_slide({header, footer, slide}) do
    present_header(header)
    present_footer(footer)

    Enum.each(slide, fn section ->
      present_section(section)
      wait_for_keypress()
    end)
  end

  def present_section({:typewrite, row}) do
    pad_row(row)
    |> String.graphemes()
    |> Enum.each(fn char ->
      IO.write(char)
      :timer.sleep(:rand.uniform(50) + 50)
    end)

    IO.puts("")
  end

  def present_section({:direct, row}) do
    pad_row(row) |> IO.puts()
  end

  def present_section({:func, func_string, func}) do
    pad_row(func_string) |> IO.puts()
    IO.puts("")
    pad()
    IO.ANSI.green() |> IO.write()
    IO.puts("Execute...\n")

    wait_for_keypress()
    center("Output") |> IO.puts()
    IO.ANSI.reset() |> IO.write()

    func.()
    IO.ANSI.green() |> IO.write()

    center("End") |> IO.puts()
    IO.ANSI.reset() |> IO.write()
  end

  def present_footer(footer) do
    height = height()
    width = width()
    IO.ANSI.cursor_down(height) |> IO.write()
    IO.ANSI.cursor_left(width) |> IO.write()

    center(footer) |> IO.write()
    IO.ANSI.cursor_up(height - 2) |> IO.write()
    IO.ANSI.cursor_left(width) |> IO.write()
  end

  def present_header(header) do
    IO.ANSI.cursor_left(width()) |> IO.write()

    center(header) |> IO.write()
  end

  def wait_for_keypress() do
    IO.read(:line)
    IO.ANSI.cursor_up(1) |> IO.write()
    IO.ANSI.cursor_left(width()) |> IO.write()
  end

  def home() do
    IO.ANSI.clear() |> IO.write()
    IO.ANSI.home() |> IO.write()
  end

  def pad() do
    IO.ANSI.cursor_right(padding()) |> IO.write()
  end

  def pad_row(row) do
    IO.ANSI.cursor_right(padding()) <>
      String.replace(row, "\n", "\n" <> IO.ANSI.cursor_right(padding()), global: true)
  end

  def center(str) do
    width = width()
    pad = div(width + String.length(str) - 2, 2)
    a = String.pad_leading(" " <> str, pad, "=")
    String.pad_trailing(a <> " ", width, "=")
  end

  def padding() do
    10
  end

  def width() do
    case :io.columns() do
      {:ok, width} -> width
      _ -> System.cmd("tput", ["cols"]) |> elem(0) |> String.trim() |> Integer.parse() |> elem(0)
    end
  end

  def height() do
    case :io.rows() do
      {:ok, height} ->
        height

      _ ->
        System.cmd("tput", ["lines"]) |> elem(0) |> String.trim() |> Integer.parse() |> elem(0)
    end
  end
end
