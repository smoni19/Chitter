require "pg"

class Peep

  attr_reader :text, :post_time, :account_id, :edited, :id
  @live_db = PG.connect(dbname: "chitter")
  @test_db = PG.connect(dbname: "chitter_test")
  @save_peep = "
    INSERT INTO peeps
    (text, post_time, account_id)
    VALUES($1, $2, $3)
    RETURNING id, text, post_time, account_id, edited;"
  @get_peeps = "SELECT * FROM peeps;"
  @get_info = "SELECT * FROM peeps WHERE id = $1;"
  @delete_peep = "
    DELETE FROM peeps
    WHERE id = $1
    RETURNING id, text, post_time, account_id, edited;"
  @edit_peep = "
    UPDATE peeps
    SET text = $1, edited = TRUE
    WHERE id = $2
    RETURNING id, text, post_time, account_id, edited;"

  def initialize(text:, post_time:, account_id:, edited:, id:)
    @text = text
    @post_time = post_time
    @account_id = account_id
    @edited = edited
    @id = id
  end

  def self.create(text:, post_time:, account_id:)
    ENV["ENVIRONMENT"] == "test" ? connection = @test_db : connection = @live_db
    result = connection.exec_params(@save_peep, [text, post_time, account_id])
    Peep.new(
      text: result[0]["text"],
      post_time: result[0]["post_time"],
      account_id: result[0]["account_id"],
      edited: result[0]["edited"],
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
        edited: peep["edited"],
        id: peep["id"])
    end
  end

  def self.edit(id:, text:)
    ENV["ENVIRONMENT"] == "test" ? connection = @test_db : connection = @live_db
    result = connection.exec_params(@edit_peep, [text, id])
    Peep.new(
      text: result[0]["text"],
      post_time: result[0]["post_time"],
      account_id: result[0]["account_id"],
      edited: result[0]["edited"],
      id: result[0]["id"])
  end

  def self.delete(id:)
    ENV["ENVIRONMENT"] == "test" ? connection = @test_db : connection = @live_db
    result = connection.exec_params(@delete_peep, [id])
    Peep.new(
      text: result[0]["text"],
      post_time: result[0]["post_time"],
      account_id: result[0]["account_id"],
      edited: result[0]["edited"],
      id: result[0]["id"])
  end

  def self.find(id:)
    return nil unless id
    ENV["ENVIRONMENT"] == "test" ? connection = @test_db : connection = @live_db
    result = connection.exec_params(@get_info, [id])
    Peep.new(
      text: result[0]["text"],
      post_time: result[0]["post_time"],
      account_id: result[0]["account_id"],
      edited: result[0]["edited"],
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

  def check_interacton(peep, page)
    peep_with_link = []
    peep = peep.split()
    peep.each do |word|
      word[0] == "#" ? link_type = "hashtag" : link_type = "mention"
      peep_with_link << create_link(word, page, link_type)
    end
    peep_with_link.join(' ')
  end

  def create_link(word, page, link_type)
    parameters = { "symbol" => "", "route" => "" }
    link_type == "hashtag" ? (parameters["symbol"] = "#"; parameters["route"] = "hashtag") : (parameters["symbol"] = "@"; parameters["route"] = "users")
    if page == "index"
      word = "<a href=\"#{parameters["route"]}/#{word[1..]}\" id=\"interaction\">#{word}</a>" if word[0] == parameters["symbol"]
    elsif page == "profile" || page == "hashtag"
      word = "<a href=\"../#{parameters["route"]}/#{word[1..]}\" id=\"interaction\">#{word}</a>" if word[0] == parameters["symbol"]
    end
    return word
  end

end
