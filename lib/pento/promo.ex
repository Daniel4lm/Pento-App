defmodule Pento.Promo do

  alias Pento.Promo.Recipient

  def send_promo(_recipient, _attrs) do
    # send email to promo recipient
    {:ok, %Recipient{}}
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking recipient changes.

  ## Examples

      iex> change_product(user)
      %Ecto.Changeset{data: %Recipient{}}

  """
  def change_recipient(%Recipient{} = user, attrs \\ %{}) do
    Recipient.changeset(user, attrs)
  end
end
