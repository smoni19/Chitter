require "pg"

class Account

  attr_reader :id, :name, :username, :email
  @live_db = PG.connect(dbname: "chitter")
  @test_db = PG.connect(dbname: "chitter_test")
  @sign_up = "INSERT INTO users (name, username, email, password) VALUES($1, $2, $3, $4) RETURNING id, name, username, email;"
  @login = "SELECT * FROM users WHERE email = $1 AND password = $2;"
  @get_info = "SELECT * FROM users WHERE id = $1;"

  def initialize(id:, name:, username:, email:)
    @id = id
    @name = name
    @username = username
    @email = email
  end

  def self.create(name:, username:, email:, password:)
    ENV["ENVIRONMENT"] == "test" ? connection = @test_db : connection = @live_db
    result = connection.exec_params(@sign_up, [name, username, email, password])
    Account.new(id: result[0]["id"], name: result[0]["name"], username: result[0]["username"], email: result[0]["email"])
  end

  def self.login(email:, password:)
    ENV["ENVIRONMENT"] == "test" ? connection = @test_db : connection = @live_db
    result = connection.exec_params(@login, [email, password])
    return unless result.any?
    Account.new(id: result[0]["id"], name: result[0]["name"], username: result[0]["username"], email: result[0]["email"])
  end

  def self.find(id:)
    return nil unless id
    ENV["ENVIRONMENT"] == "test" ? connection = @test_db : connection = @live_db
    result = connection.exec_params(@get_info, [id])
    Account.new(id: result[0]['id'], name: result[0]["name"], username: result[0]['username'], email: result[0]['email'])
  end

end
