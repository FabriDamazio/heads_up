defmodule HeadsUpWeb.EffortLive do
  use HeadsUpWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, responders: 0, minutes_per_responder: 10)}
  end

  def render(assigns) do
    ~H"""
    <div class="effort">
      <h1>Community Love</h1>
      <section>
        <button phx-click="add" phx-value-quantity="3">
          +  3
        </button>
        <div>
          <%= @responders %>
        </div>
        &times;
        <div>
          <%= @minutes_per_responder %>
        </div>
        =
        <div>
          <%= @responders * @minutes_per_responder %>
        </div>
      </section>

      <form phx-submit="recalculate">
        <label>Minutes per responder:</label>
        <input type="number" name="minutes" value={@minutes_per_responder} />
      </form>
    </div>
    """
  end

  def handle_event("add", %{"quantity" => quantity}, socket) do
    {:noreply, update(socket, :responders, &(&1 + String.to_integer(quantity)))}
  end

  def handle_event("recalculate", %{"minutes" => minutes}, socket) do
    {:noreply, assign(socket, :minutes_per_responder, String.to_integer(minutes))}
  end
end
