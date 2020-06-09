defmodule RessipyWeb.AccountController do
  use RessipyWeb, :controller
  alias Ressipy.Accounts

  def index(conn, _params) do
    changeset = Accounts.phone_number_changeset()
    render(conn, "login.html", changeset: changeset)
  end

  def login(conn, %{"phone" => number}) do
    with {:ok, number} <- Accounts.send_verification(number) do
      changeset = Accounts.verification_changeset(%{number: number})
      render(conn, "verify.html", changeset: changeset)
    else
      {:error, %{valid?: false} = changeset} ->
        conn
        |> put_flash(:error, "Phone number is invalid")
        |> render("login.html", changeset: changeset)
    end
  end

  def logout(conn, _) do
    conn
    |> clear_session()
    |> redirect(to: "/")
  end

  def verify(conn, %{"verification" => code}) do
    with {:ok, user} <- Accounts.verify_phone(code) do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Welcome, #{user.first_name}!")
      |> redirect(to: Routes.category_path(conn, :index))
    else
      {:not_found, changeset} ->
        conn
        |> put_flash(:error, "No account could be found with this phone number")
        |> render("verify.html", changeset: changeset)

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Code is incorrect")
        |> render("verify.html", changeset: changeset)
    end
  end
end
