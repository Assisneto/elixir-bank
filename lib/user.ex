defmodule User do
  defstruct name: nil, email: nil
  def new(name, email), do: %__MODULE__{name: name, email: email}

end
