defmodule Pento.Catalog do
  @moduledoc """
  The Catalog context.
  """

  import Ecto.Query, warn: false
  alias Pento.Repo

  alias Pento.Catalog.Product
  alias Pento.Catalog.ProductQuery

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)
  end

  def sort_products(sort_by, sort_options \\ %{}) do
    ProductQuery.Query.sort_by(sort_by, sort_options)
    |> Repo.all()
  end

  def list_products_with_user_rating(user) do
    ProductQuery.Query.by_user_ratings(user)
    |> Repo.all()
  end

  def list_products_with_average_ratings(%{
        age_group_filter: age_group_filter
      }) do
    ProductQuery.Query.with_average_ratings()
    |> ProductQuery.Query.join_users()
    |> ProductQuery.Query.join_demographics()
    |> ProductQuery.Query.filter_by_age_group(age_group_filter)
    |> Repo.all()
  end

  def list_products_with_zero_ratings do
    ProductQuery.Query.with_zero_ratings()
    |> Repo.all()
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  #def get_product_by_sku(sku_num), do: Repo.all(from p in Product, where: p.sku == ^sku_num)
  def get_product_by_sku(sku_num), do: Repo.get_by(Product, sku: sku_num)

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Change the price of product.

  ## Examples

      iex> markdown_product(product, :increase, 44)
      {:ok, %Product{}}

      iex> markdown_product(product, :increase, bad_value)
      {:error, %Ecto.Changeset{}}

  """
  def markdown_product(%Product{} = product, oper, amount \\ 0) do
    product
    |> Product.changeset()
    |> Product.price_changeset(oper, amount)
    |> Repo.update()
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end
end
