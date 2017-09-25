defmodule Microblog.MessagesTest do
  use Microblog.DataCase

  alias Microblog.Messages

  describe "posts" do
    alias Microblog.Messages.Post

    @valid_attrs %{text: "some text"}
    @update_attrs %{text: "some updated text"}
    @invalid_attrs %{text: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Messages.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Messages.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Messages.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Messages.create_post(@valid_attrs)
      assert post.text == "some text"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messages.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, post} = Messages.update_post(post, @update_attrs)
      assert %Post{} = post
      assert post.text == "some updated text"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Messages.update_post(post, @invalid_attrs)
      assert post == Messages.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Messages.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Messages.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Messages.change_post(post)
    end
  end
end
