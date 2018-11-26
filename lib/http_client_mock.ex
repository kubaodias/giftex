defmodule HTTPClientMock.Response do
  @moduledoc """

    Minimal mock struct of HTTP response

  ## Examples

      iex(1)> %HTTPClientMock.Response{}
      %HTTPClientMock.Response{body: nil, status_code: nil}

  """
  defstruct [:status_code, :body]
end

defmodule HTTPClientMock do
  @moduledoc """

    Minimal mock of HTTP client

  """
  def post(_url, _data) do
    body = Poison.encode!(%{
      "responseCode" => "OK",
      "errorId" => 0,
      "message" => "Successful",
      "data" => 13342340
    })

    %HTTPClientMock.Response{
      status_code: 200,
      body: body
    }
  end
end
