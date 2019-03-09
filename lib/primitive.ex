defmodule Primitive do
  def run_query(query) do
    :timer.sleep(2000)
    "#{query} done"
  end
end
