defmodule Pento.SupportTest do
  use Pento.DataCase

  alias Pento.Support

  describe "faqs" do
    alias Pento.Support.Faq

    import Pento.SupportFixtures

    @invalid_attrs %{question: nil, title: nil}

    test "list_faqs/0 returns all faqs" do
      faq = faq_fixture()
      assert Support.list_faqs() == [faq]
    end

    test "get_faq!/1 returns the faq with given id" do
      faq = faq_fixture()
      assert Support.get_faq!(faq.id) == faq
    end

    test "create_faq/1 with valid data creates a faq" do
      valid_attrs = %{question: "some question", title: "some title"}

      assert {:ok, %Faq{} = faq} = Support.create_faq(valid_attrs)
      assert faq.question == "some question"
      assert faq.title == "some title"
    end

    test "create_faq/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Support.create_faq(@invalid_attrs)
    end

    test "update_faq/2 with valid data updates the faq" do
      faq = faq_fixture()
      update_attrs = %{question: "some updated question", title: "some updated title"}

      assert {:ok, %Faq{} = faq} = Support.update_faq(faq, update_attrs)
      assert faq.question == "some updated question"
      assert faq.title == "some updated title"
    end

    test "update_faq/2 with invalid data returns error changeset" do
      faq = faq_fixture()
      assert {:error, %Ecto.Changeset{}} = Support.update_faq(faq, @invalid_attrs)
      assert faq == Support.get_faq!(faq.id)
    end

    test "delete_faq/1 deletes the faq" do
      faq = faq_fixture()
      assert {:ok, %Faq{}} = Support.delete_faq(faq)
      assert_raise Ecto.NoResultsError, fn -> Support.get_faq!(faq.id) end
    end

    test "change_faq/1 returns a faq changeset" do
      faq = faq_fixture()
      assert %Ecto.Changeset{} = Support.change_faq(faq)
    end
  end

  describe "answers" do
    alias Pento.Support.Answer

    import Pento.SupportFixtures

    @invalid_attrs %{content: nil, username: nil}

    test "list_answers/0 returns all answers" do
      answer = answer_fixture()
      assert Support.list_answers() == [answer]
    end

    test "get_answer!/1 returns the answer with given id" do
      answer = answer_fixture()
      assert Support.get_answer!(answer.id) == answer
    end

    test "create_answer/1 with valid data creates a answer" do
      valid_attrs = %{content: "some content", username: "some username"}

      assert {:ok, %Answer{} = answer} = Support.create_answer(valid_attrs)
      assert answer.content == "some content"
      assert answer.username == "some username"
    end

    test "create_answer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Support.create_answer(@invalid_attrs)
    end

    test "update_answer/2 with valid data updates the answer" do
      answer = answer_fixture()
      update_attrs = %{content: "some updated content", username: "some updated username"}

      assert {:ok, %Answer{} = answer} = Support.update_answer(answer, update_attrs)
      assert answer.content == "some updated content"
      assert answer.username == "some updated username"
    end

    test "update_answer/2 with invalid data returns error changeset" do
      answer = answer_fixture()
      assert {:error, %Ecto.Changeset{}} = Support.update_answer(answer, @invalid_attrs)
      assert answer == Support.get_answer!(answer.id)
    end

    test "delete_answer/1 deletes the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{}} = Support.delete_answer(answer)
      assert_raise Ecto.NoResultsError, fn -> Support.get_answer!(answer.id) end
    end

    test "change_answer/1 returns a answer changeset" do
      answer = answer_fixture()
      assert %Ecto.Changeset{} = Support.change_answer(answer)
    end
  end
end
