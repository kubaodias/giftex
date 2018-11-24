defmodule GiftexDraw do
  @moduledoc """
  Documentation for GiftexDraw.
  """

  @doc """
  Draw members assignments for gifts giving

  ## Examples

      iex> GiftexDraw.run([])
      %{}

      iex> GiftexDraw.run([%GiftexMember{name: "Jack Smith"}, %GiftexMember{name: "Diane Black"}])
      %{"Jack Smith" => "Diane Black", "Diane Black" => "Jack Smith"}

      iex> GiftexDraw.run([%GiftexMember{name: "Jack Smith", exclude: ["Diane Black"]}, %GiftexMember{name: "Diane Black"}, %GiftexMember{name: "Peter Williams"}])
      %{"Jack Smith" => "Peter Williams", "Peter Williams" => "Diane Black", "Diane Black" => "Jack Smith"}

      iex> GiftexDraw.run([%GiftexMember{name: "Jack Smith"}])
      nil

      iex> GiftexDraw.run([%GiftexMember{name: "Jack Smith"}, %GiftexMember{name: "Diane Black", exclude: ["Jack Smith"]}])
      nil

  """
  def run(members) do
    draw(members, 0)
  end

  defp draw(members, m) when m == length(members) do
    # when whole list has been permutated
    validate_members(members)
  end
  defp draw(members, m) do
    Enum.reduce_while(m..length(members) - 1,
      nil,
      fn n, acc ->
        # swap elements at m-th and n-th positions
        {elem1, _} = List.pop_at(members, m)
        {elem2, _} = List.pop_at(members, n)

        assignments = members
        |> List.replace_at(m, elem2)
        |> List.replace_at(n, elem1)
        |> draw(m + 1)

        case assignments do
          nil ->
            {:cont, acc}
          _ ->
            {:halt, assignments}
        end
      end
    )
  end

  defp validate_members([]) do
    %{}
  end
  defp validate_members([head_member | members]) do
    try do
      members
      # duplicate all members apart from the head so they can be assigned into pairs
      |> Enum.flat_map(fn member -> [member, member] end)
      # insert first member at tail and head of the list
      |> List.insert_at(length(members) * 2, head_member)
      |> List.insert_at(0, head_member)
      # split into pairs - it'll return [[m1,m2],[m2,m3],[m3,m1]]
      |> Enum.chunk_every(2)
      |> Enum.map(
        fn [%GiftexMember{name: m1, exclude: exclude}, %GiftexMember{name: m2}] ->
          # check if first member doesn't exclude the second member in pair
          case (m1 == m2) or Enum.member?(exclude, m2) do
            true ->
              raise "Member #{m2} is in excluded list of #{m1}"
            false ->
              {m1, m2}
          end
        end
      )
      # convert to map e.g. %{m1 => m2, m2 => m3, m3 => m1}
      |> Map.new
    rescue
      RuntimeError ->
        nil
    end
  end

end
