class MyOpenTok
  attr_reader :opentok

  API_KEY = '23300482'.freeze
  API_SECRET = '55f3cbd9ba275405d8dbaa7307611dfcb9f60a78'.freeze

  def initialize
    @opentok = OpenTok::OpenTokSDK.new(API_KEY, API_SECRET)
  end

  def generate_token(session_id)
    @opentok.generateToken(session_id: session_id)
  end

  def create_session(location)
    @opentok.createSession(location)
  end
end