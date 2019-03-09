defmodule Presentation do
  @moduledoc """
  Documentation for Presentation.
  """
  def width() do
    case :io.columns() do
      {:ok, width} -> width
      _ -> System.cmd("tput", ["cols"]) |> elem(0) |> String.strip() |> Integer.parse() |> elem(0)
    end
  end

  def height() do
    case :io.rows() do
      {:ok, height} ->
        height
      _ ->
        System.cmd("tput", ["lines"]) |> elem(0) |> String.strip() |> Integer.parse() |> elem(0)
    end
  end

  def present(presentation) do
    IO.ANSI.clear() |> IO.write()
    IO.ANSI.home() |> IO.write()

    Enum.each(presentation, fn slide ->
      present_slide(slide)
      IO.ANSI.clear() |> IO.write()
      IO.ANSI.home() |> IO.write()
    end)
  end

  def present_slide({header, footer, slide}) do
    present_header(header)
    present_footer(footer)

    Enum.each(slide, fn section ->
      present_section(section)
      IO.read(:line)
      IO.ANSI.cursor_up(1) |> IO.write()
      IO.ANSI.cursor_left(width()) |> IO.write()
    end)
  end

  def center(str) do
    width = width()
    pad = div(width + String.length(str) - 2, 2)
    a = String.pad_leading(" " <> str, pad, "=")
    b = String.pad_trailing(a <> " ", width, "=")
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

  def present_section({:typewrite, rows}) do
    Enum.each(rows, fn row ->
      row
      |> String.graphemes()
      |> Enum.each(fn char ->
        IO.write(char)
        Process.sleep(:rand.uniform(50) + 50)
      end)

      # IO.ANSI.cursor_down(1) |> IO.write()
      # IO.ANSI.cursor_left(width()) |> IO.write()
    end)
  end

  def present_section({:direct, rows}) do
    Enum.each(rows, fn row ->
      IO.write(row)
      # IO.ANSI.cursor_down(1) |> IO.write()
      # IO.ANSI.cursor_left(width()) |> IO.write()
    end)
  end
end
