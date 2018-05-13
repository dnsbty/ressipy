defmodule Ressipy.Web.InstructionController do
  use Ressipy.Web, :controller

  alias Ressipy.Recipes

  plug Ressipy.Web.Plugs.EnsureAuthenticated when not action in [:index, :show]

  def index(conn, _params) do
    instructions = Recipes.list_instructions()
    render(conn, "index.html", instructions: instructions)
  end

  def new(conn, _params) do
    changeset = Recipes.change_instruction(%Ressipy.Recipes.Instruction{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"instruction" => instruction_params}) do
    case Recipes.create_instruction(instruction_params) do
      {:ok, instruction} ->
        conn
        |> put_flash(:info, "Instruction created successfully.")
        |> redirect(to: instruction_path(conn, :show, instruction))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    instruction = Recipes.get_instruction!(id)
    render(conn, "show.html", instruction: instruction)
  end

  def edit(conn, %{"id" => id}) do
    instruction = Recipes.get_instruction!(id)
    changeset = Recipes.change_instruction(instruction)
    render(conn, "edit.html", instruction: instruction, changeset: changeset)
  end

  def update(conn, %{"id" => id, "instruction" => instruction_params}) do
    instruction = Recipes.get_instruction!(id)

    case Recipes.update_instruction(instruction, instruction_params) do
      {:ok, instruction} ->
        conn
        |> put_flash(:info, "Instruction updated successfully.")
        |> redirect(to: instruction_path(conn, :show, instruction))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", instruction: instruction, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    instruction = Recipes.get_instruction!(id)
    {:ok, _instruction} = Recipes.delete_instruction(instruction)

    conn
    |> put_flash(:info, "Instruction deleted successfully.")
    |> redirect(to: instruction_path(conn, :index))
  end
end
