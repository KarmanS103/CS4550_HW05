defmodule BullsWeb.GameChannel do
  use BullsWeb, :channel

  alias Bulls.Game

  # Handling the user joining the channel
  # Attribution: Nat Tuck's Lecture 8 Code
  @impl true
  def join("game:" <> _id, payload, socket) do
    if authorized?(payload) do
      game = Game.new
      socket = assign(socket, :game, game)
      view = Game.view(game)
      {:ok, view, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Handling the guess input from the user
  # Attribution: Nat Tuck's Lecture 8 Code
  @impl true
  def handle_in("guess", %{"guess" => gs}, socket) do
    game0 = socket.assigns[:game]
    game1 = Bulls.Game.guess(game0, gs)
    socket = assign(socket, :game, game1)
    view = Bulls.Game.view(game1)
    {:reply, {:ok, view}, socket}
  end

  # Handling the reset call from the user
  # Attribution: Nat Tuck's Lecture 8 Code
  @impl true
  def handle_in("reset", _, socket) do
    game = Game.new
    socket = assign(socket, :game, game)
    view = Game.view(game)
    {:reply, {:ok, view}, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
