defmodule UrlShortenerWeb.UrlView do
  use UrlShortenerWeb, :view
  alias UrlShortenerWeb.UrlView

  def render("show.json", %{url: url}) do
    %{data: render_one(url, UrlView, "link.json")}
  end

  def render("link.json", %{url: url}) do
    %{hash: url.hash, url: url.url}
  end

  def render("error.json", %{message: message}) do
    %{error: message}
  end
end
