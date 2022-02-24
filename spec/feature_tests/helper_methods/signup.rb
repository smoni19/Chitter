def signup(name, username, email, password)
  visit("/signup")
  fill_in("name", with: name)
  fill_in("username", with: username)
  fill_in("email", with: email)
  fill_in("password", with: password)
  click_button("Sign up!")
end
