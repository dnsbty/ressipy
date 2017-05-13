defmodule Ressipy.Web.InstructionControllerTest do
  use Ressipy.Web.ConnCase

  alias Ressipy.Recipes

  @create_attrs %{order: 42, text: "some text"}
  @update_attrs %{order: 43, text: "some updated text"}
  @invalid_attrs %{order: nil, text: nil}

  def fixture(:instruction) do
    {:ok, instruction} = Recipes.create_instruction(@create_attrs)
    instruction
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, instruction_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Instructions"
  end

  test "renders form for new instructions", %{conn: conn} do
    conn = get conn, instruction_path(conn, :new)
    assert html_response(conn, 200) =~ "New Instruction"
  end

  test "creates instruction and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, instruction_path(conn, :create), instruction: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == instruction_path(conn, :show, id)

    conn = get conn, instruction_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Instruction"
  end

  test "does not create instruction and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, instruction_path(conn, :create), instruction: @invalid_attrs
    assert html_response(conn, 200) =~ "New Instruction"
  end

  test "renders form for editing chosen instruction", %{conn: conn} do
    instruction = fixture(:instruction)
    conn = get conn, instruction_path(conn, :edit, instruction)
    assert html_response(conn, 200) =~ "Edit Instruction"
  end

  test "updates chosen instruction and redirects when data is valid", %{conn: conn} do
    instruction = fixture(:instruction)
    conn = put conn, instruction_path(conn, :update, instruction), instruction: @update_attrs
    assert redirected_to(conn) == instruction_path(conn, :show, instruction)

    conn = get conn, instruction_path(conn, :show, instruction)
    assert html_response(conn, 200) =~ "some updated text"
  end

  test "does not update chosen instruction and renders errors when data is invalid", %{conn: conn} do
    instruction = fixture(:instruction)
    conn = put conn, instruction_path(conn, :update, instruction), instruction: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Instruction"
  end

  test "deletes chosen instruction", %{conn: conn} do
    instruction = fixture(:instruction)
    conn = delete conn, instruction_path(conn, :delete, instruction)
    assert redirected_to(conn) == instruction_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, instruction_path(conn, :show, instruction)
    end
  end
end
