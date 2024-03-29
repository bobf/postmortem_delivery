defmodule PostmortemDeliveryWeb.EmailController do
  use PostmortemDeliveryWeb, :controller

  alias PostmortemDelivery.Deliveries
  alias PostmortemDelivery.Deliveries.Email

  alias Jason

  action_fallback PostmortemDeliveryWeb.FallbackController

  def create(conn, %{"email" => email_params}) do
    with {:ok, %Email{} = email} <- Deliveries.create_email(email_params, conn.remote_ip) do
      conn
      |> put_layout(false)
      |> render("create.json", email: email)
    end
  end

  def show(conn, %{"uri" => uri}) do
    email = Deliveries.get_email_by_uri(uri)
    conn
    |> put_layout(false)
    |> render("show.html", email: email, initial_data: Deliveries.encode_email(email))
  end
end
