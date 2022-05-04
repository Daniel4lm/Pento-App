# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pento.Repo.insert!(%Pento.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Pento.Repo

alias Pento.Accounts
alias Pento.Catalog
alias Pento.Catalog.Product

user1 = %{username: "Daniel4lm", email: "daniel4molnar@gmail.com", password: "fdsfsUfT4k214l4WW"}
user2 = %{username: "Danila1992Sabaton", email: "danilajurgon@gmail.com", password: "Grozdovi4444333"}

# Accounts.register_user(user1)
# Accounts.register_user(user2)

products = [
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

# Enum.each(products, fn product ->
#   Catalog.create_product(product)
# end)
