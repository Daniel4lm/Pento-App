defmodule Pento.SupportFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pento.Support` context.
  """

  @doc """
  Generate a faq.
  """
  def faq_fixture(attrs \\ %{}) do
    {:ok, faq} =
      attrs
      |> Enum.into(%{
        question: "some question",
        title: "some title"
      })
      |> Pento.Support.create_faq()

    faq
  end

  @doc """
  Generate a answer.
  """
  def answer_fixture(attrs \\ %{}) do
    {:ok, answer} =
      attrs
      |> Enum.into(%{
        content: "some content",
        username: "some username"
      })
      |> Pento.Support.create_answer()

    answer
  end
end
