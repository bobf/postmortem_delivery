defmodule PostmortemDelivery.Deliveries do
  @moduledoc """
  The Deliveries context.
  """

  import Ecto.Query, warn: false
  alias PostmortemDelivery.Repo

  alias PostmortemDelivery.Deliveries.Email

  @doc """
  Returns the list of emails.

  ## Examples

      iex> list_emails()
      [%Email{}, ...]

  """
  def list_emails do
    Repo.all(Email)
  end

  @doc """
  Gets a single email by provided URI.
  """
  def get_email_by_uri(uri), do: Repo.one!(from email in Email, where: email.uri == ^uri)

  @doc """
  Gets a single email.

  Raises `Ecto.NoResultsError` if the Email does not exist.

  ## Examples

      iex> get_email!(123)
      %Email{}

      iex> get_email!(456)
      ** (Ecto.NoResultsError)

  """
  def get_email!(id), do: Repo.get!(Email, id)

  @doc """
  Creates a email.

  ## Examples

      iex> create_email(%{field: value})
      {:ok, %Email{}}

      iex> create_email(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_email(attrs, remote_ip) do
    email_attrs = translated_params(attrs)
    |> with_expiry
    |> with_uri
    |> with_remote_ip(remote_ip)

    %Email{}
    |> Email.changeset(email_attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a email.

  ## Examples

      iex> update_email(email, %{field: new_value})
      {:ok, %Email{}}

      iex> update_email(email, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_email(%Email{} = email, attrs) do
    email
    |> Email.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a email.

  ## Examples

      iex> delete_email(email)
      {:ok, %Email{}}

      iex> delete_email(email)
      {:error, %Ecto.Changeset{}}

  """
  def delete_email(%Email{} = email) do
    Repo.delete(email)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking email changes.

  ## Examples

      iex> change_email(email)
      %Ecto.Changeset{data: %Email{}}

  """
  def change_email(%Email{} = email, attrs \\ %{}) do
    Email.changeset(email, attrs)
  end

  def with_remote_ip(attrs, ip) do
    remote_ip = Enum.join(Tuple.to_list(ip), ".")
    Map.merge(attrs, %{"source_ip" => remote_ip})
  end

  def with_uri(attrs) do
    Map.merge(attrs, %{"uri" => SecureRandom.hex(8)})
  end

  def with_expiry(attrs) do
    one_week = 7 * 24 * 60 * 60
    Map.merge(attrs, %{"expires_at" => DateTime.add(DateTime.utc_now(), one_week, :second)})
  end

  def translated_params(attrs) do
    %{
      html_body: attrs["htmlBody"],
      text_body: attrs["textBody"],
      from: attrs["from"],
      reply_to: attrs["replyTo"],
      to: attrs["to"],
      cc: attrs["cc"],
      bcc: attrs["bcc"],
      subject: attrs["subject"],
      message_id: attrs["messageId"]
    }
  end
end
