defmodule Zstream.Decoder.Deflate do
  @moduledoc false
  @behaviour Zstream.Decoder

  def init() do
    z = :zlib.open()
    :ok = :zlib.inflateInit(z, -15)
    z
  end

  def decode(chunk, z) do
    chunk = IO.iodata_to_binary(chunk)
    {:zlib.inflate(z, chunk), z}
  end

  def close(z) do
    :ok = :zlib.inflateEnd(z)
    :ok = :zlib.close(z)
    ""
  end
end
