# Readme

`Spike.Surface` provides a wrapper around
[Surface.LiveView](https://hexdocs.pm/surface/Surface.LiveView.html) and
[Surface.LiveComponent](https://hexdocs.pm/surface/Surface.LiveComponent.html#content),
which simplifies working with memory-backed forms, including nested forms that require
contextual validation.

## Installation

[Available in Hex](https://hex.pm/packages/spike_surface), the package can be installed
by adding `spike_surface` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:spike_surface, "~> 0.2"}
  ]
end
```

Documentation can be found at <https://hexdocs.pm/spike_surface>.

## Quick start

Once installed in a Phoenix project, open up your `*_web.ex` file and add the following
functions:

```
  def form_surface_live_view do
    quote do
      use Surface.LiveView,
        layout: {MyAppWeb.LayoutView, "live.html"}

      unquote(view_helpers())

      use Spike.Surface
    end
  end

  def form_surface_live_component do
    quote do
      use Surface.LiveComponent

      unquote(view_helpers())

      use Spike.Surface
    end
  end
```

[See Spike.LiveView](http://hexdocs.pm/spike_liveview) for walkthrough, which is applicable
here, and also see [Spike Example app](https://github.com/hubertlepicki/spike_example) for 
Spike + Surface UI examples.

For starting point to build your own form components,
see our [Components Library](components_library.md).

