defmodule Spike.Surface.Errors do
  use Surface.Component

  prop(form, :struct, required: true)
  prop(field, :atom, required: true)
  prop(errors, :map, required: true)
  prop(dirty_fields, :list, required: false, default: nil)
  prop(field_errors, :list, required: false, default: nil)

  slot(default, arg: %{field_errors: :list})

  def render(assigns) do
    assigns =
      if assigns.dirty_fields do
        assigns
      else
        assign(assigns, :dirty_fields, Spike.dirty_fields(assigns.form))
      end

    assigns =
      assigns |> assign(:field_errors, field_errors(assigns))

    ~F"""
      <#slot :if={@field_errors} {@default, field_errors: @field_errors} />
    """
  end

  defp field_errors(%{errors: errors, form: form, field: field, dirty_fields: dirty_fields}) do
    if errors[form.ref] && errors[form.ref] |> Map.get(field) &&
         dirty_fields[form.ref] && field in dirty_fields[form.ref] do
      errors[form.ref][field]
    else
      []
    end
  end
end
