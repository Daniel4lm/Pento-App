defmodule Pento.Promo.Recipient do
  import Ecto.Changeset

  defstruct [:first_name, :email]

  @types %{first_name: :string, email: :string}

  def changeset(%__MODULE__{} = user, attrs \\ %{}) do
    {user, @types}
    |> cast(attrs, [:first_name, :email])
    |> validate_required([:first_name, :email])
    |> validate_length(:first_name, min: 3, max: 100, message: "Name should be at least 3 character(s), max 100")
    |> validate_format(:first_name, ~r/^[A-Z]/, message: "Name begins only with uppercase letter")
    |> validate_format(:email, ~r/.*@.*.com/, message: "Invalid email format")
  end
end
