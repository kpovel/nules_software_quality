defmodule Lab2 do
  def start(_type, _args) do
    IO.puts("hello")

    # Bookstore.run()
    Supervisor.start_link([], strategy: :one_for_one)
  end
end
