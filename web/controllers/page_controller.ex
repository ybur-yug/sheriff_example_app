defmodule Sebastian.PageController do
  use Sebastian.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
