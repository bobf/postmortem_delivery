defmodule PostmortemDeliveryWeb.EmailControllerTest do
  use PostmortemDeliveryWeb.ConnCase

  alias PostmortemDelivery.Deliveries
  alias PostmortemDelivery.Deliveries.Email

  @create_attrs %{
    expires_at: "2010-04-17T14:00:00Z",
    headers: %{},
    html_body: "some html_body",
    source_ip: "some source_ip",
    text_body: "some text_body",
    uri: "some uri"
  }
  @update_attrs %{
    expires_at: "2011-05-18T15:01:01Z",
    headers: %{},
    html_body: "some updated html_body",
    source_ip: "some updated source_ip",
    text_body: "some updated text_body",
    uri: "some updated uri"
  }
  @invalid_attrs %{expires_at: nil, headers: nil, html_body: nil, source_ip: nil, text_body: nil, uri: nil}

  def fixture(:email) do
    {:ok, email} = Deliveries.create_email(@create_attrs)
    email
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all emails", %{conn: conn} do
      conn = get(conn, Routes.email_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create email" do
    test "renders email when data is valid", %{conn: conn} do
      conn = post(conn, Routes.email_path(conn, :create), email: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.email_path(conn, :show, id))

      assert %{
               "id" => id,
               "expires_at" => "2010-04-17T14:00:00Z",
               "headers" => %{},
               "html_body" => "some html_body",
               "source_ip" => "some source_ip",
               "text_body" => "some text_body",
               "uri" => "some uri"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.email_path(conn, :create), email: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update email" do
    setup [:create_email]

    test "renders email when data is valid", %{conn: conn, email: %Email{id: id} = email} do
      conn = put(conn, Routes.email_path(conn, :update, email), email: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.email_path(conn, :show, id))

      assert %{
               "id" => id,
               "expires_at" => "2011-05-18T15:01:01Z",
               "headers" => %{},
               "html_body" => "some updated html_body",
               "source_ip" => "some updated source_ip",
               "text_body" => "some updated text_body",
               "uri" => "some updated uri"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, email: email} do
      conn = put(conn, Routes.email_path(conn, :update, email), email: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete email" do
    setup [:create_email]

    test "deletes chosen email", %{conn: conn, email: email} do
      conn = delete(conn, Routes.email_path(conn, :delete, email))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.email_path(conn, :show, email))
      end
    end
  end

  defp create_email(_) do
    email = fixture(:email)
    %{email: email}
  end
end
