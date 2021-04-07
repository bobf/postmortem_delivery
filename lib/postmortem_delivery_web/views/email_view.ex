defmodule PostmortemDeliveryWeb.EmailView do
  use PostmortemDeliveryWeb, :view
  alias PostmortemDeliveryWeb.EmailView

  def render("create.json", %{email: email}) do
    %{uri: email.uri, expiresAt: email.expires_at}
  end
end
