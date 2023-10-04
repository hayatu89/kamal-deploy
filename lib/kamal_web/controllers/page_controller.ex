defmodule KamalWeb.PageController do
  use KamalWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def healthcheck(conn, _params) do
    render(conn, "OK")
  end
end
