defmodule Pento.SkuSearch.SkuModel do
  defstruct [:sku_num]

  import Ecto.Changeset

  @types %{sku_num: :integer}

  def changeset(%__MODULE__{} = sku, attrs \\ %{}) do
    {sku, @types}
    |> cast(attrs, [:sku_num])
    |> validate_required([:sku_num])
    |> validate_number(:sku_num, greater_than: 0.0, message: "SKU number must be positive")
    |> validate_sku_length(:sku_num)
  end

  def validate_sku_length(changeset, field) when is_atom(field) do
    field_value = get_field(changeset, field)
    validate_change(changeset, field, fn field, value ->
      case length(Integer.digits(field_value)) >= 7 do
        true ->
          []

        false ->
          [{field, "SKU must have at least 7 digits"}]
      end
    end)
  end
end
