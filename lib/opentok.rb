class Opentok
  API_KEY = '23300482'
  API_SECRET = '55f3cbd9ba275405d8dbaa7307611dfcb9f60a78'
  OTSDK = OpenTok::OpenTokSDK.new API_KEY, API_SECRET

  def self.sdk
    "Hey"
  end
end