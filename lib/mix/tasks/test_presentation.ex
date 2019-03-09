defmodule Mix.Tasks.TestPresentation do
  use Mix.Task

  def run(_) do
    IO.puts(IO.ANSI.clear())
    Presentation.present(test_presentation())
  end

  def test_presentation do
    [
      {"Sida 1 - Dynamiska typer", "1 / 3",
       [
         {:direct, ["Erlang/OTP 21 [erts-10.2.5] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe] [dtrace]

Interactive Elixir (1.8.1) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> "]},
         {:typewrite, [IO.ANSI.cursor_right(7)<>" 1 + 3"]},
         {:direct, ["\n4
iex(2)>"]}
       ]},
      {"Sida 2 - Filtar", "2 / 3",
       [
         {:typewrite, ["Rad ett med text", "Detta är en till rad", "Och en sista rad"]},
         {:direct, ["Rad 4", "Rad 5"]}
       ]},
      {"Sida 3 - Skogen", "3 / 3",
       [
         {:typewrite, ["Rad ett med text", "Detta är en till rad", "Och en sista rad"]},
         {:direct, ["Rad 4", "Rad 5"]}
       ]}
    ]
  end
end
