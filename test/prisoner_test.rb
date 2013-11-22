require './test/test_helper'
require './lib/prisoner'

class PrisonerTest < MiniTest::Test

  def atts
    {
      "id" => "12345",
      "imprisoned_at" => Time.now.utc,
      "uri" => "/prisoners/12345",
      "guesses" => "/prisoners/12345/guesses",
      "misses" => [],
      "word" => "************",
      "state" => "help",
      "guesses_remaining" => 18
    }
  end

  def test_it_exists
    assert Prisoner
  end

  def test_it_initializes
    p = Prisoner.new(atts)
    assert_equal p.id, atts["id"]
  end

end
