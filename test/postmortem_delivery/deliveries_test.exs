defmodule PostmortemDelivery.DeliveriesTest do
  use PostmortemDelivery.DataCase

  alias PostmortemDelivery.Deliveries

  describe "emails" do
    alias PostmortemDelivery.Deliveries.Email

    @valid_attrs %{expires_at: "2010-04-17T14:00:00Z", headers: %{}, html_body: "some html_body", source_ip: "some source_ip", text_body: "some text_body", uri: "some uri"}
    @update_attrs %{expires_at: "2011-05-18T15:01:01Z", headers: %{}, html_body: "some updated html_body", source_ip: "some updated source_ip", text_body: "some updated text_body", uri: "some updated uri"}
    @invalid_attrs %{expires_at: nil, headers: nil, html_body: nil, source_ip: nil, text_body: nil, uri: nil}

    def email_fixture(attrs \\ %{}) do
      {:ok, email} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Deliveries.create_email()

      email
    end

    test "list_emails/0 returns all emails" do
      email = email_fixture()
      assert Deliveries.list_emails() == [email]
    end

    test "get_email!/1 returns the email with given id" do
      email = email_fixture()
      assert Deliveries.get_email!(email.id) == email
    end

    test "create_email/1 with valid data creates a email" do
      assert {:ok, %Email{} = email} = Deliveries.create_email(@valid_attrs)
      assert email.expires_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert email.headers == %{}
      assert email.html_body == "some html_body"
      assert email.source_ip == "some source_ip"
      assert email.text_body == "some text_body"
      assert email.uri == "some uri"
    end

    test "create_email/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Deliveries.create_email(@invalid_attrs)
    end

    test "update_email/2 with valid data updates the email" do
      email = email_fixture()
      assert {:ok, %Email{} = email} = Deliveries.update_email(email, @update_attrs)
      assert email.expires_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert email.headers == %{}
      assert email.html_body == "some updated html_body"
      assert email.source_ip == "some updated source_ip"
      assert email.text_body == "some updated text_body"
      assert email.uri == "some updated uri"
    end

    test "update_email/2 with invalid data returns error changeset" do
      email = email_fixture()
      assert {:error, %Ecto.Changeset{}} = Deliveries.update_email(email, @invalid_attrs)
      assert email == Deliveries.get_email!(email.id)
    end

    test "delete_email/1 deletes the email" do
      email = email_fixture()
      assert {:ok, %Email{}} = Deliveries.delete_email(email)
      assert_raise Ecto.NoResultsError, fn -> Deliveries.get_email!(email.id) end
    end

    test "change_email/1 returns a email changeset" do
      email = email_fixture()
      assert %Ecto.Changeset{} = Deliveries.change_email(email)
    end
  end
end
