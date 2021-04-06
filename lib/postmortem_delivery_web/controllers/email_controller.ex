defmodule PostmortemDeliveryWeb.EmailController do
  use PostmortemDeliveryWeb, :controller

  alias PostmortemDelivery.Deliveries
  alias PostmortemDelivery.Deliveries.Email

  action_fallback PostmortemDeliveryWeb.FallbackController

  def create(conn, %{"email" => email_params}) do
    IO.puts("********************************")
    IO.puts(inspect(email_params))
    IO.puts("********************************")
    email = Deliveries.create_email(email_params, conn.remote_ip)
    conn
    |> put_layout(false)
    |> render("show.json", email: email)
    # with {:ok, %Email{} = email} <- Deliveries.create_email(params, conn.remote_ip) do
    #   conn
    #   |> put_status(:created)
    #   |> put_resp_header("location", Routes.email_path(conn, :show, email))
    #   |> render("show.json", email: email)
    # end
  end

  def show(conn, %{"uri" => uri}) do
    email = Deliveries.get_email_by_uri(uri)
    conn
    |> put_layout(false)
    |> render("show.html", email: email)
  end
end
