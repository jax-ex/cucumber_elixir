defmodule CucumberElixir do
  def tokenize(file) do
    file = File.read!(file)
    tokenize_string({[], %{}, nil}, file)
  end

  def tokenize_string({tokens, token, state}, "Feature:" <> tail) do
    tokenize_string({tokens, %{keyword: :feature}, :feature_name}, tail)
  end

  def tokenize_string({acc, token, :feature_name}, <<head::binary-1, tail::binary>>) do
    name = Map.get(token, :name, "") <> head
    token = Map.put(token, :name, name)
    tokenize_string({acc, token, :feature_name}, tail)
  end

  def tokenize_string({acc, token, :feature_description}, <<head::binary-1, tail::binary>>) do
    description = Map.get(token, :description, "") <> head
    token = Map.put(token, :description, description)
    tokenize_string({acc, token, :feature_description}, tail)
  end

  def tokenize_string({acc, token}, "\n" <> tail, :feature_name) do
    token =
      token
      |> Map.put(:name, name <> "\n")
      |> Map.put(description: "")

    tokenize_string({acc, token, :feature_description}, tail)
  end

  def tokenize_string(acc, _string), do: acc
end
