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
         {
           :direct,
           "rad"
         },
         {
           :direct,
           "rad\en ny rad"
         },
         {
           :func,
           "def run_query(query) do
  :timer.sleep(2000)
  \"\#{query} done\"
end",
           fn -> Primitive.run_query("query 1") |> IO.puts() end
         },
         {:direct,
          "Erlang/OTP 21 [erts-10.2.5] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe] [dtrace]

Interactive Elixir (1.8.1) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> "},
         {:typewrite, IO.ANSI.cursor_right(7) <> IO.ANSI.cursor_up(1) <> " 1 + 3"}
       ]},
      {"Sida 2 - Knasiga trådar", "2 / 3",
       [
         {
           :direct,
           "rad"
         },
         {
           :direct,
           "rad\en ny rad"
         },
         {
           :func,
           "def run_query(query) do
  :timer.sleep(2000)
  \"\#{query} done\"
end",
           fn -> Primitive.run_query("query 1") |> IO.puts() end
         },
         {:direct,
          "Erlang/OTP 21 [erts-10.2.5] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe] [dtrace]

Interactive Elixir (1.8.1) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> "},
         {:typewrite, IO.ANSI.cursor_right(7) <> IO.ANSI.cursor_up(1) <> " 1 + 3"}
       ]},
      {"Sida 3 - Vansinnig formattering", "3 / 3",
       [
         {
           :direct,
           "rad"
         },
         {
           :direct,
           "rad\en ny rad"
         },
         {
           :func,
           "def run_query(query) do
  :timer.sleep(2000)
  \"\#{query} done\"
end",
           fn -> Primitive.run_query("query 1") |> IO.puts() end
         },
         {:direct,
          "Erlang/OTP 21 [erts-10.2.5] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe] [dtrace]

Interactive Elixir (1.8.1) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> "},
         {:typewrite, IO.ANSI.cursor_right(7) <> IO.ANSI.cursor_up(1) <> " 1 + 3"}
       ]}
    ]
  end
end
