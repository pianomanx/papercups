defmodule ChatApi.Uploads do
  @moduledoc """
  The Tags context.
  """
  import Ecto.Query, warn: false
  alias ChatApi.Repo

  alias ChatApi.Uploads.Upload

  @spec create_upload(:invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}) ::
          any
  def create_upload(attrs \\ %{}) do
    %Upload{}
    |> Upload.changeset(attrs)
    |> Repo.insert()
  end
end
