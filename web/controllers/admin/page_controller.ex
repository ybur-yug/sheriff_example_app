defmodule Sebastian.Admin.PageController do
  use Sebastian.Web, :controller

  def index(conn, _params) do
    current_user = Guardian.Plug.current_resource(conn)
    render(conn, "index.html")
  end
end
