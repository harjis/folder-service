# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Backend.Repo.insert!(%Backend.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Ecto.Multi

if Mix.env() !== :test do
  Multi.new()
  |> Multi.run(:generate, fn _, _ -> Backend.Folders.generate(3, 10) end)
  |> Backend.Repo.transaction()
end
