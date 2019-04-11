defmodule UrlShortenWeb.UrlController do
  use UrlShortenWeb, :controller

  alias UrlShorten.Links
  alias UrlShorten.Links.Url

  def create(conn, %{"url" => url_param}) do
    down_url = String.downcase(url_param)

    case validate_url(down_url) do
      {:ok, valid_url} ->
        with {:ok, %Url{} = url} <- Links.create_url(valid_url) do
          fq_link =
            current_url(conn)
            |> String.replace(current_path(conn), "/")

          url = Map.put(url, :hash, fq_link <> url.hash)

          conn
          |> put_status(:created)
          |> render("show.json", url: url)
        end

      {:error, message} ->
        conn
        |> put_status(:accepted)
        |> render("error.json", message: message)
    end
  end

  def get_and_redirect(conn, %{"id" => id}) do
    case Links.get_url(id) do
      %Url{:url => url} -> redirect(conn, external: url)
      _ -> redirect(conn, to: "/")
    end
  end

  defp validate_url(url) do
    uri = URI.parse(url)

    case uri do
      %URI{scheme: nil} -> validate_url("http://" <> url)
      %URI{host: nil} -> {:error, uri}
      uri -> check_url(uri, url)
    end
  end

  defp check_url(uri, url) do
    host_check = :inet.gethostbyname(to_charlist(uri.host))

    case host_check do
      {:ok, _} -> {:ok, url}
      _ -> {:error, "There is an error with the supplied URL"}
    end
  end
end
