defmodule Chopperbot.Split.InputTransformer do
  alias Chopperbot.Split.Order

  @doc """
  Transform inputs to a list of orders.

  ## Examples
      iex> transform(["turbo", "10", "kendo", "200"])
      {:ok, [{"turbo", 10.0}, {"kendo", 200.0}]}

      iex> transform(["ant", "200", "pipe", "100", "share", "-30"])
      {:ok, [{"ant", 200.0}, {"pipe", 100.0}, {"share", -30.0}]}

      iex> transform(["Satoshi", "10.9", "Takeshi", "390.13", "satoshi", "112.50",])
      {:ok, [{"satoshi", 10.9}, {"takeshi", 390.13}, {"satoshi", 112.5}]}

      iex> transform([])
      {:ok, []}

      iex> transform(["turbo", "ten", "kendo", "twenty"])
      {:error, :invalid_input, ["ten", "twenty"]}

      iex> transform(["turbo", "100", "kendo", "200", "chopper"])
      {:error, :invalid_input, ["chopper"]}

      iex> transform(["turbo", "ten", "kendo", "200", "chopper"])
      {:error, :invalid_input, ["ten", "chopper"]}
  """
  @spec transform([String.t()]) :: {:ok, [Order.t()]} | {:error, :invalid_input, [String.t()]}
  def transform(inputs) do
    input_pairs = Enum.chunk_every(inputs, 2)

    case transform_to_orders(input_pairs) do
      {orders, []} ->
        {:ok, orders}

      {_, invalid_inputs} ->
        {:error, :invalid_input, invalid_inputs}
    end
  end

  defp transform_to_orders(input_pairs, orders \\ [], invalid_inputs \\ [])

  defp transform_to_orders([[name, amount] | rest_input_pairs], orders, invalid_inputs) do
    case Float.parse(amount) do
      {float_amount, ""} ->
        order = {String.downcase(name), float_amount}
        transform_to_orders(rest_input_pairs, [order | orders], invalid_inputs)

      _ ->
        transform_to_orders(rest_input_pairs, orders, [amount | invalid_inputs])
    end
  end

  defp transform_to_orders([[no_pair] | rest_input_pairs], orders, invalid_inputs) do
    transform_to_orders(rest_input_pairs, orders, [no_pair | invalid_inputs])
  end

  defp transform_to_orders([], orders, invalid_inputs) do
    {Enum.reverse(orders), Enum.reverse(invalid_inputs)}
  end
end
