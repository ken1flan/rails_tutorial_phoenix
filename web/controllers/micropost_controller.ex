defmodule RailsTutorialPhoenix.MicropostController do
  use RailsTutorialPhoenix.Web, :controller

  alias RailsTutorialPhoenix.Micropost

  plug :scrub_params, "micropost" when action in [:create, :update]

  def index(conn, _params) do
    microposts = Repo.all(Micropost)
    |> Repo.preload(:user)
    render(conn, "index.html", microposts: microposts)
  end

  def new(conn, _params) do
    changeset = Micropost.changeset(%Micropost{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"micropost" => micropost_params}) do
    changeset = Micropost.changeset(%Micropost{}, micropost_params)

    case Repo.insert(changeset) do
      {:ok, _micropost} ->
        conn
        |> put_flash(:info, "Micropost created successfully.")
        |> redirect(to: micropost_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    micropost = Repo.get!(Micropost, id)
    |> Repo.preload(:user)
    render(conn, "show.html", micropost: micropost)
  end

  def edit(conn, %{"id" => id}) do
    micropost = Repo.get!(Micropost, id)
    changeset = Micropost.changeset(micropost)
    render(conn, "edit.html", micropost: micropost, changeset: changeset)
  end

  def update(conn, %{"id" => id, "micropost" => micropost_params}) do
    micropost = Repo.get!(Micropost, id)
    changeset = Micropost.changeset(micropost, micropost_params)

    case Repo.update(changeset) do
      {:ok, micropost} ->
        conn
        |> put_flash(:info, "Micropost updated successfully.")
        |> redirect(to: micropost_path(conn, :show, micropost))
      {:error, changeset} ->
        render(conn, "edit.html", micropost: micropost, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    micropost = Repo.get!(Micropost, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(micropost)

    conn
    |> put_flash(:info, "Micropost deleted successfully.")
    |> redirect(to: micropost_path(conn, :index))
  end
end
