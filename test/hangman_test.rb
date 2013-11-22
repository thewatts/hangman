require './test/test_helper'
require './lib/hangman'
require 'json'

class HangmanTest < MiniTest::Test

  attr_reader :h

  def setup
    @h = Hangman.new
  end

  def prisoners_stub
    items = {
      "items" => [
        {
          "id" => "12345",
          "imprisoned_at" => Time.now.utc,
          "uri" => "/prisoners/12345",
          "guesses" => "/prisoners/12345/guesses",
          "misses" => [],
          "word" => "************",
          "state" => "help",
          "guesses_remaining" => 18
        },
        {
          "id" => "7891011",
          "imprisoned_at" => Time.now.utc,
          "uri" => "/prisoners/789011",
          "guesses" => "/prisoners/789011/guesses",
          "misses" => [],
          "word" => "************",
          "state" => "help",
          "guesses_remaining" => 18
        }
      ]
    }

    Faraday::Adapter::Test::Stubs.new do |stub|
      stub.get('/prisoners') { [200, {}, items] }
    end
  end

  def test_it_exists
    assert Hangman
  end

  def test_it_has_a_base_url
    #skip
    assert_equal "http://balanced-hangman.herokuapp.com", h.url
  end

  def test_it_has_me_url
    #skip
    assert_equal "/me", h.me_url
  end

  def test_it_has_prisoners_url
    #skip
    assert_equal "/prisoners", h.prisoners_url
  end

  def test_assert_200_from_get_url
    #skip
    assert_equal 200, h.get(h.url).status
  end

  def test_assert_body_from_base_url
    #skip
    desired_result = {
      "me"        => "/me",
      "index"     => "/",
      "prisoners" => "/prisoners"
    }
    assert_equal desired_result, h.j(h.get(h.url).body)
  end

  def test_it_has_login_info
    #skip
    assert_equal 'reg@nathanielwatts.com', h.username
    assert_equal 'asdf', h.password
  end

  def test_it_can_authenticate_prisoners_url_with_username_password
    skip
    assert_equal 201, h.post(h.prisoners_url).status
  end

  def test_it_parses_body_of_most_recent_response
    #skip
    body = {
      "me"        => "/me",
      "index"     => "/",
      "prisoners" => "/prisoners"
    }
    h.get(h.url)
    assert_equal body, h.body
  end

  def test_it_can_get_prisoners
    skip
    test = Faraday.new do |builder|
      builder.adapter :test, prisoners_stub do |stub|
        stub.get('/') {[200, {}, '']}
      end
    end
    resp = test.get '/prisoners'
    assert_equal "asdf", resp.body
  end

end
