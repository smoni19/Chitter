def create_peep(text, user)
  Peep.create(text: text, post_time: Time.now.to_s, account_id: user.id)
end