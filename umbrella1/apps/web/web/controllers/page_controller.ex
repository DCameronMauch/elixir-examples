defmodule Umbrella1.Web.PageController do
  use Umbrella1.Web.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
