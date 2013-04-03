class MyOpenTok
  attr_reader :opentok

  API_KEY = '24997742'.freeze
  API_SECRET = '9b6ce15af724472873beb9187144d477f5c9a180'.freeze

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