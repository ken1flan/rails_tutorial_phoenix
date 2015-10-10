defmodule RailsTutorialPhoenix.PageController do
  use RailsTutorialPhoenix.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
