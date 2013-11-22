require 'faraday'
require 'json'
require './lib/prisoner'

class Hangman

  attr_reader :url, :me_url, :prisoners_url, :response

  def initialize
    @url = "http://balanced-hangman.herokuapp.com"
    @me_url = "/me"
    @prisoners_url = "/prisoners"
  end

  def username
    'reg@nathanielwatts.com'
  end

  def password
    'asdf'
  end

  def conn
    @conn ||= Faraday.new(:url => url) do |faraday|
      faraday.request  :url_encoded
      faraday.basic_auth(username, password)
      #faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def get(url)
    @response = conn.get do |req|
      req.url url
      req.headers['Content-Type'] = 'application/json'
    end
  end

  def post(url, body = nil)
    @response = conn.post do |req|
      req.url url
      req.headers['Content-Type'] = 'application/json'
      req.body = body
    end
  end

  def body
    j(response.body)
  end

  def j(value)
    JSON.parse(value)
  end

  def prisoners
    raw_prisoners = j(get(prisoners_url).body)["items"]
    raw_prisoners.map { |data| Prisoner.new(data) }
  end

  def next_prisoner
    prisoners.find { |prisoner| prisoner.state == "help" }
  end

  def saved_prisoners
    prisoners.find_all { |prisoner| prisoner.state == "rescued" }
  end

  def guess(guess)
    body = {"guess" => guess}.to_json
    response = post(next_prisoner.guesses, body)
    updated_attributes = j(response.body)
    next_prisoner.update(updated_attributes)
  end

end
