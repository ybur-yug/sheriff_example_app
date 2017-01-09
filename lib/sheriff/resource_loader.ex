defmodule Sebastian.UserLoader do
  @moduledoc false
  @behaviour Sheriff.ResourceLoader

  alias Sebastian.Repo
  alias Sebastian.User

  def fetch_resource(:show, %{"id" => id}), do: Repo.get(User, id)
  def fetch_resource({:get, "/admin/pages"}, %{role: "admin"}), do: Repo.all(User)
  # current catch all
  def fetch_resource({:get, "/admin/pages"}, %{}), do: Repo.all(User)
end
