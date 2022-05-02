defmodule Pento.SkuSearch do

  alias Pento.SkuSearch.SkuModel

  alias Pento.Catalog

  def sku_search(sku_num) do
    sku = Catalog.get_product_by_sku(sku_num)
    sku
  end

  def change_sku(%SkuModel{} = sku, attrs \\ %{}) do
    SkuModel.changeset(sku, attrs)
  end

end
