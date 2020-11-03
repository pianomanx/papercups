defmodule ChatApi.Uploads.Upload do
  use Ecto.Schema
  import Ecto.Changeset

  alias ChatApi.Messages.Message
  alias ChatApi.Accounts.Account

  schema "uploads" do
    field :file_url, :string
    belongs_to(:account, Account)
    belongs_to(:message, Message)

    timestamps()
  end

  @spec changeset(
          {map, map} | %{:__struct__ => atom | %{__changeset__: map}, optional(atom) => any},
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def changeset(struct, params \\ :invalid) do
    struct
    |> cast(params, [:file_url])
    |> validate_required([:file_url])
  end
end
