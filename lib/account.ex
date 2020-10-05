defmodule Account do
    defstruct user: User, balance: 1000
    def registration(user), do: %__MODULE__{user: user, balance: 1000}

    def transfer(accounts, from, to, value) do
     from = find_account(accounts,from)

      cond do

        balance_validation(from.balance, value) -> {:error, "insufficient funds"}

        true ->
          to = find_account(accounts, to)
          from = %Account{from | balance: from.balance - value}
          to = %Account{to | balance: to.balance + value}

        [from, to]
      end
    end

    def withdraw(account, value) do
      cond do
        balance_validation(account.balance, value) -> {:error, "insufficient funds"}

        true ->
          %Account{account | balance: account.balance - value}
      end

    end

    defp balance_validation(balance, value), do: balance < value
    defp find_account(accounts, account), do: Enum.find(accounts, &(&1.user.email == account.user.email))
end
