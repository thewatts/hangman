class Prisoner

  attr_reader :id, :imprisoned_at, :uri, :guesses
  attr_accessor :misses, :guesses_remaining, :word, :hits, :state

  def initialize(attributes)
    @id                = attributes["id"]
    @imprisoned_at     = attributes["imprisoned_at"]
    @uri               = attributes["uri"]
    @guesses           = attributes["guesses"]
    @misses            = attributes["misses"]
    @word              = attributes["word"]
    @state             = attributes["state"]
    @guesses_remaining = attributes["guesses_remaining"]
  end

  def update(attributes)
    @misses            = attributes["misses"]
    @guesses_remaining = attributes["guesses_remaining"]
    @word              = attributes["word"]
    @hits              = attributes["hits"]
    @state             = attributes["state"]
    self
  end
end
