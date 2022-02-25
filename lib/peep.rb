require "pg"

class Peep

  attr_reader :text, :post_time, :account_id, :id
  @live_db = PG.connect(dbname: "chitter")
  @test_db = PG.connect(dbname: "chitter_test")
  @save_peep = "
    INSERT INTO peeps
    (text, post_time, account_id)
    VALUES($1, $2, $3)
    RETURNING id, text, post_time, account_id;"
  @get_peeps = "SELECT * FROM peeps;"
  @delete_peep = "
    DELETE FROM peeps
    WHERE id = $1
    RETURNING id, text, post_time, account_id;"

  def initialize(text:, post_time:, account_id:, id:)
    @text = text
    @post_time = post_time
    @account_id = account_id
    @id = id
  end

  def self.create(text:, post_time:, account_id:)
    ENV["ENVIRONMENT"] == "test" ? connection = @test_db : connection = @live_db
    result = connection.exec_params(@save_peep, [text, post_time, account_id])
    Peep.new(
      text: result[0]["text"],
      post_time: result[0]["post_time"],
      account_id: result[0]["account_id"],
      id: result[0]["id"])
  end

  def self.all
    ENV["ENVIRONMENT"] == "test" ? connection = @test_db : connection = @live_db
    result = connection.exec_params(@get_peeps)
    result.map do |peep|
      Peep.new(
        text: peep["text"],
        post_time: peep["post_time"],
        account_id: peep["account_id"],
        id: peep["id"])
    end
  end

  def self.delete(id:)
    ENV["ENVIRONMENT"] == "test" ? connection = @test_db : connection = @live_db
    result = connection.exec_params(@delete_peep, [id])
    Peep.new(
      text: result[0]["text"],
      post_time: result[0]["post_time"],
      account_id: result[0]["account_id"],
      id: result[0]["id"])
  end

  def find_user_info
    Account.find(id: account_id)
  end

  def convert_time(post_time)
    day = Time.parse(post_time).strftime("%d").to_i
    Time.parse(post_time).strftime("%R - %a #{ordinalise(day)} %b '%y")
  end

  def ordinalise(day)
    if (11..13).include?(day % 100)
      "#{day}th"
    else
      case day % 10
        when 1; day = "#{day}st"
        when 2; day = "#{day}nd"
        when 3; day = "#{day}rd"
        else    day = "#{day}th"
      end
    end
  end

  def check_hashtag(peep, page)
    peep_with_link = []
    peep = peep.split()
    peep.each do |word|
      peep_with_link << convert_to_link(word, page)
    end
    return peep_with_link.join(' ')
  end

  def convert_to_link(word, page)
    if page == "index"
      word = "<a href=\"hashtag/#{word[1..]}\" id=\"hashtag\">#{word}</a>" if word[0] == "#"
    elsif page == "profile" || page == "hashtag"
      word = "<a href=\"../hashtag/#{word[1..]}\" id=\"hashtag\">#{word}</a>" if word[0] == "#"
    end
    return word
  end

end
