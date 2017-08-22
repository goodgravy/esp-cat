defmodule TranslateTest do
  use ExUnit.Case
  doctest Translate

  test "works bueno" do
    assert Translate.esp_to_cat("bueno") == "bon"
  end
end
