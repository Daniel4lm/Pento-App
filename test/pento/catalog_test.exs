defmodule Pento.CatalogTest do
  use Pento.DataCase

  alias Pento.Catalog

  @products [
    %{
      name: "Chess",
      description: "The classic strategy game",
      sku: 5_678_910,
      unit_price: 10.00
    },
    %{
      name: "Tic-Tac-Toe",
      description: "The game of Xs and Os",
      sku: 11_121_314,
      unit_price: 3.00
    },
    %{
      name: "Table Tennis",
      description: "Bat the ball back and forth. Don't miss!",
      sku: 15_222_324,
      unit_price: 12.00
    }
  ]

  describe "products" do
    alias Pento.Catalog.Product

    import Pento.CatalogFixtures

    @invalid_attrs %{description: nil, name: nil, sku: nil, unit_price: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Catalog.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Catalog.get_product!(product.id) == product
    end

    test "get_product_by_sku/1 returns the product by SKU" do
      product = product_fixture()

      assert Catalog.get_product_by_sku(product.sku) == product

    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{description: "some description", name: "some name", sku: 42, unit_price: 120.5}

      assert {:ok, %Product{} = product} = Catalog.create_product(valid_attrs)
      assert product.description == "some description"
      assert product.name == "some name"
      assert product.sku == 42
      assert product.unit_price == 120.5
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_product(@invalid_attrs)
    end

    test "markdown_product/3 change the product price" do

      temp_product = product_fixture()
      product = Catalog.get_product!(temp_product.id)
      {:ok, markdown_product} = Catalog.markdown_product(product, :increase, 4)

      assert markdown_product.unit_price == product.unit_price + 4

    end

    test "markdown_product/3 does not change the product price" do

      temp_product = product_fixture()
      product = Catalog.get_product!(temp_product.id)
      {:ok, markdown_product} = Catalog.markdown_product(product, :decrease, -1444)

      assert markdown_product.unit_price == product.unit_price

    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name", sku: 43, unit_price: 456.7}

      assert {:ok, %Product{} = product} = Catalog.update_product(product, update_attrs)
      assert product.description == "some updated description"
      assert product.name == "some updated name"
      assert product.sku == 43
      assert product.unit_price == 456.7
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_product(product, @invalid_attrs)
      assert product == Catalog.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Catalog.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Catalog.change_product(product)
    end
  end

  describe "products with ratings" do
    alias Pento.Catalog.Product
    import Pento.CatalogFixtures

    alias Pento.Accounts
    import Pento.AccountsFixtures

    alias Pento.Survey

    test "list_products_with_user_rating/1 returns valid data" do

      %{id: id} = user = user_fixture(%{id: 1, email: "daniel4molnar@gmail.com"})
      ruser = Accounts.get_user!(id)

       Enum.each(@products, fn product ->
          {:ok, prod} = Catalog.create_product(product)
          Survey.create_rating(%{stars: :rand.uniform(5), user_id: id, product_id: prod.id})

       end)

      products = Catalog.list_products_with_user_rating(ruser)

      assert length(Enum.at(products, 1).ratings) > 0

    end

    test "list_products_with_zero_ratings/0 return products without ratings" do

      Enum.each(@products, fn product ->
        {:ok, prod} = Catalog.create_product(product)
     end)

      list_products = Catalog.list_products_with_zero_ratings()

      IO.inspect(list_products)

      assert Enum.all?(list_products, fn {name, rating} -> rating == 0 end)
    end

  end
end
