defmodule Spike.Surface.FormField do
  use Surface.Component

  prop(form, :struct, required: true)
  prop(field, :atom, required: true)
  prop(target, :any, required: false, default: nil)
  prop(submit_event, :string, required: false, default: "submit")

  slot(default)

  @impl true
  def render(assigns) do
    ~F"""
    <form phx-change="spike-form-event:set-value" phx-target={@target} phx-submit={@submit_event}>      
      <input name="ref" type="hidden" value={@form.ref} />
      <input name="field" type="hidden" value={@field} />
      <#slot />
    </form>
    """
  end
end
