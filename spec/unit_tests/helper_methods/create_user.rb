def create_user(name, username, email, password)
  Account.create(name: name, username: username, email: email, password: password)
end
