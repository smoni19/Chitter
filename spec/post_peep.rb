def post_peep(text)
  fill_in("text", with: text)
  click_button("Peep!")
end
