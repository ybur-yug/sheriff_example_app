defmodule Sebastian.UserLoader do
  @moduledoc false
  @behaviour Sheriff.ResourceLoader

  alias Sebastian.Repo

  def fetch_resource(:show, %{"id" => id}), do: Repo.get(User, id)
  def fetch_resource(:index, _params), do: Repo.all(User)
end
