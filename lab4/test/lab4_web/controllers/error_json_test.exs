defmodule Lab4Web.ErrorJSONTest do
  use Lab4Web.ConnCase, async: true

  test "renders 404" do
    assert Lab4Web.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert Lab4Web.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
