defmodule Spike.Surface.Errors do
  use Surface.Component

  prop(form, :struct, required: true)
  prop(field, :atom, required: true)
  prop(errors, :map, required: true)
  prop(dirty_fields, :map, required: false, default: nil)

  slot(default, args: [:field_errors])

  def render(assigns) do
    assigns =
      if assigns.dirty_fields == nil do
        assign(assigns, :dirty_fields, Spike.dirty_fields(assigns.form))
      else
        assigns
      end

    if field_errors(assigns) != [] do
      ~F"""
        <#slot :args={field_errors: field_errors(assigns)} />
      """
    else
      ~F"""
      """
    end
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
