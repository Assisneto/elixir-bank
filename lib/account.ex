defmodule Account do
    defstruct user: User, balance: 1000
    @accounts "accounts.txt"
    def registration(user) do

      case find_account(user) do
        nil ->
         [%__MODULE__{user: user}] ++ get_accounts()
         |> set_accounts

        _ -> {:error, "account already exists"}
      end

    end
    def transfer(from, to, value) do
     from = find_account(from.user)
      cond do
        balance_validation(from.balance, value) -> {:error, "insufficient funds"}
        true ->
          accounts = delete([from,to])

          from = %Account{from | balance: from.balance - value}
          to = %Account{to | balance: to.balance + value}

          accounts = accounts ++ [from, to]

          set_accounts(accounts)

          {:ok, from, to, "Sucess"}
      end
    end

    def withdraw(account, value) do
      cond do
        balance_validation(account.balance, value) -> {:error, "insufficient funds"}
        true ->
          accounts = delete([account])

          account = %Account{account | balance: account.balance - value}
          accounts = accounts ++ account

          set_accounts(accounts)
          {:ok, account, "Sucess"}
      end

    end

    defp balance_validation(balance, value), do: balance < value

    defp find_account(user), do: Enum.find(get_accounts(), &(&1.user.email == user.email))

    def get_accounts do
      {:ok, binary} = File.read(@accounts)
      :erlang.binary_to_term(binary)
    end

    defp set_accounts (accounts) do
      binary_accounts = :erlang.term_to_binary(accounts)
      File.write(@accounts,  binary_accounts)
    end

    defp delete(accounts) do
      Enum.reduce(accounts, get_accounts(), fn c, acc -> List.delete(acc,c) end)
    end
end
