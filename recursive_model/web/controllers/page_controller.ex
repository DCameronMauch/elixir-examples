defmodule RecursiveModel.PageController do
  use RecursiveModel.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
