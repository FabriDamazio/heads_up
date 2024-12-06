defmodule HeadsUpWeb.CustomComponents do
  use Phoenix.Component

  attr :status, :atom, required: true, values: [:pending, :resolved, :canceled]
  attr :class, :string, default: nil
  attr :rest, :global

  def badge(assigns) do
    ~H"""
    <div
      class={[
        "rounded-md px-2 py-1 text-xs font-medium uppercase inline-block border",
        @status == :resolved && "text-lime-600 border-lime-600",
        @status == :pending && "text-amber-600 border-amber-600",
        @status == :canceled && "text-gray-600 border-gray-600",
        @class
      ]}
      {@rest}
    >
      <%= @status %>
    </div>
    """
  end

  slot :inner_block, required: true
  slot :tagline

  def headline(assigns) do
    assigns = assign_new(assigns, :emoji, fn -> ~w(😎 🤩 🥳) |> Enum.random() end)

    ~H"""
    <div class="headline">
      <h1>
        <%= render_slot(@inner_block) %>
      </h1>
      <div :for={tag <- @tagline} class="tagline">
        <%= render_slot(tag, @emoji) %>
      </div>
    </div>
    """
  end
end
