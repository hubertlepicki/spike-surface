# Components Library

This library only comes with building blocks for your components, and you should
built your own form components - or use the provided building blocks directly.

Feel free to grab and customize these components to your needs, and treat them
as a starting point when building your form builder.

The code below is released under public domain:

    defmodule MyAppWeb.Surface.FormComponents do
      defmodule Label do
        use Surface.Component

        prop(form, :struct, required: true)
        prop(field, :atom, required: true)
        prop(text, :string, required: true)
        prop(required, :boolean, required: false, default: false)

        def render(assigns) do
          ~F"""
          {#if @required}
            <label for={"#{@form.ref}_#{@field}"}>* {@text}</label>
          {#else}
            <label for={"#{@form.ref}_#{@field}"}>{@text}</label>
          {/if}
          """
        end
      end

      defmodule Errors do
        use Surface.Component

        prop(form, :struct, required: true)
        prop(errors, :map, required: true)
        prop(field, :atom, required: true)

        def render(assigns) do
          ~F"""
          <Spike.Surface.Errors form={@form} errors={@errors} field={@field} :let={field_errors: field_errors}>
            <span class="error">
              {#for {_key, message} <- field_errors}
                {message}<br/>
              {/for}
            </span>
          </Spike.Surface.Errors>
          """
        end
      end

      defmodule Input do
        use Surface.Component
        alias MyAppWeb.Surface.FormComponents.{Errors, Label}

        prop(form, :struct, required: true)
        prop(type, :string, required: true)
        prop(errors, :map, required: true)
        prop(field, :atom, required: true)

        prop(label, :string, required: false)
        prop(target, :any, required: false, default: nil)
        prop(options, :list, required: false, default: [])

        prop(checked_value, :string, required: false, default: "1")
        prop(unchecked_value, :string, required: false, default: "0")

        def render(%{type: type} = assigns) when type in ["text", "password", "email", "textarea"] do
          ~F"""
          <div>
            {#if @label}
              <Label form={@form} field={@field} text={@label} required={is_required?(@form, @field)} />
            {/if}

            <Spike.Surface.FormField form={@form} field={@field} target={@target}>
              {#if @type == "textarea"}
                <textarea id={"#{@form.ref}_#{@field}"} name="value">{ @form |> Map.get(@field) }</textarea>
              {#else}
                <input id={"#{@form.ref}_#{@field}"} type={@type} name="value" value={@form |> Map.get(@field)} />
              {/if}
            </Spike.Surface.FormField>

            <Errors form={@form} field={@field} errors={@errors} />
          </div> 
          """
        end

        def render(%{type: "select", options: _} = assigns) do
          ~F"""
          <div>
            {#if @label}
              <Label form={@form} field={@field} text={@label} required={is_required?(@form, @field)} />
            {/if}

            <Spike.Surface.FormField form={@form} field={@field} target={@target}>
              <select id={"#{@form.ref}_#{@field}"} name="value">
                {#for {value, text} <- @options}
                  <option value={value || ""} selected={@form |> Map.get(@field) == value}>{ text }</option>
                {/for}
              </select>
            </Spike.Surface.FormField>

            <Errors form={@form} field={@field} errors={@errors} />
          </div> 
          """
        end

        def render(%{type: "checkbox", options: _} = assigns) do
          ~F"""
          <div>
            <Spike.Surface.FormField form={@form} field={@field} target={@target}>
              <span class="float-left">
                <input id={"#{@form.ref}_#{@field}_unchecked"} name="value" type="hidden" value={@unchecked_value} />
                <input id={"#{@form.ref}_#{@field}"} name="value" type="checkbox" value={@checked_value} checked={is_checked?(@form, @field, @checked_value)} />
              </span>

              <span>
                {#if @label}
                  <Label form={@form} field={@field} text={@label} required={is_required?(@form, @field)} />
                {/if}
              </span>
            </Spike.Surface.FormField>

            <Errors form={@form} field={@field} errors={@errors} />
          </div> 
          """
        end

        defp is_checked?(form, field, checked_value) do
          Map.get(form, field) == checked_value || Map.get(form, field) == true
        end

        defp is_required?(form, field) do
          validations = Vex.Extract.settings(form) |> Map.get(field, [])
          {:presence, true} in validations
        end
      end
    end

Also see [Spike Example app](https://github.com/hubertlepicki/spike_example) for more examples.
