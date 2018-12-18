defmodule UrlShortener.Links.Url do
  use Ecto.Schema
  import Ecto.Changeset

  alias UrlShorten.Ecto.HashId

  @primary_key {:hash, HashId, [autogenerate: true]}
  @derive {Phoenix.Param, key: :hash}
  schema "urls" do
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:url])
    |> validate_required([:url])
    |> unique_constraint(:url)
  end
end
