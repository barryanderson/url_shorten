defmodule UrlShorten.Links do
  @moduledoc """
  The Links context.
  """

  import Ecto.Query, warn: false
  alias UrlShorten.Repo

  alias UrlShorten.Links.Url

  @doc """
  Gets a single url.

  Raises `Ecto.NoResultsError` if the Url does not exist.

  ## Examples

      iex> get_url!(123)
      %Url{}

      iex> get_url!(456)
      ** (Ecto.NoResultsError)

  """
  def get_url(id), do: Repo.get(Url, id)

  @doc """
  Creates a url.

  ## Examples

      iex> create_url(%{field: value})
      {:ok, %Url{}}

      iex> create_url(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_url(url) do
    hash = get_hash(url)

    cond do
      hash ->
        {:ok, hash}

      true ->
        %Url{}
        |> Url.changeset(%{url: url})
        |> Repo.insert()
    end
  end

  defp get_hash(url), do: Repo.get_by(Url, url: url)
end
