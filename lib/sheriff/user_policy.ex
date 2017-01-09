defmodule Sebastian.UserPolicy do
  @moduledoc false
  @behaviour Sheriff.Policy

  alias Sebastian.User

  # Admins can see all the things
  def permitted?(%User{role: "admin"}, _request, _resource), do: true

  # Users can access themselves
  def permitted?(%User{id: id}, _request, %User{id: id}), do: true

  # No match, no access
  def permitted?(_, _, _), do: false
end
