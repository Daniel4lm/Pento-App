defmodule Pento.Promo.Recipient do
  import Ecto.Changeset

  defstruct [:first_name, :email]

  @types %{first_name: :string, email: :string}

  def changeset(%__MODULE__{} = user, attrs \\ %{}) do
    {user, @types}
    |> cast(attrs, [:first_name, :email])
    |> validate_required([:first_name, :email])
    |> validate_format(:email, ~r/@/)
  end
end
