defmodule Spike.Surface do
  defmacro __using__(_opts) do
    quote do
      data(form, :struct)
      data(errors, :map, default: %{})

      @before_compile unquote(Spike.LiveView)
    end
  end
end
