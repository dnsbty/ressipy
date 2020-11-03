alias Ressipy.{
  Accounts.User,
  Repo
}

Repo.insert!(%User{
  first_name: "Dennis",
  last_name: "Beatty",
  phone: "+12107718253"
})
