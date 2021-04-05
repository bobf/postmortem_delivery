defmodule PostmortemDeliveryWeb.EmailView do
  use PostmortemDeliveryWeb, :view
  alias PostmortemDeliveryWeb.EmailView

  def render("show.json", %{email: email}) do
    %{data: render_one(email, EmailView, "email.json")}
  end

  def render("email.json", %{email: email}) do
    %{uri: email.uri, expires_at: email.expires_at}
  end
end
