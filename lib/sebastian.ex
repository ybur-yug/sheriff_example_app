defmodule Sebastian do
  @moduledoc false
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Sebastian.Repo, []),
      supervisor(Sebastian.Endpoint, []),
    ]

    opts = [strategy: :one_for_one, name: Sebastian.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    Sebastian.Endpoint.config_change(changed, removed)
    :ok
  end
end
