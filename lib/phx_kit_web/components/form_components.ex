defmodule PhxKitWeb.FormComponents do
  @moduledoc """
  Form components
  """
  use Phoenix.Component
  alias Phoenix.LiveView.JS
  import PhxKitWeb.Gettext
  import PhxKitWeb.HelperComponents

  embed_templates "commons/form/*"

  @doc """

  """
  # attr :current_date, :string, default: "2020-01-01"
  attr :id, :any
  attr :name, :any
  attr :label, :string, default: nil
  attr :value, :any
  attr :field, :any, doc: "a %Phoenix.HTML.Form{}/field name tuple, for example: {f, :email}"
  attr :errors, :list

  def input_date(%{field: {f, field}} = assigns) do
    assigns
    |> assign(field: nil)
    |> assign_new(:name, fn ->
      name = Phoenix.HTML.Form.input_name(f, field)
    end)
    |> assign_new(:id, fn -> Phoenix.HTML.Form.input_id(f, field) end)
    |> assign_new(:value, fn -> Phoenix.HTML.Form.input_value(f, field) end)
    |> assign_new(:errors, fn -> translate_errors(f.errors || [], field) end)
    |> input_date()
  end

  def input_date(assigns) do
    ~H"""
    <div phx-feedback-for={@name}>
      <.date_picker
        label={@label}
        name={@name}
        id={@id || @name}
        value={@value}
        class={[
          input_border(@errors),
          "mt-2 block w-full rounded-lg border-zinc-300 py-[7px] px-[11px]",
          "text-zinc-900 focus:outline-none focus:ring-4 sm:text-sm sm:leading-6",
          "phx-no-feedback:border-zinc-300 phx-no-feedback:focus:border-zinc-400 phx-no-feedback:focus:ring-zinc-800/5"
        ]}
      />
    </div>
    """
  end
end
