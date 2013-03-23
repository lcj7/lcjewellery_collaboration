require 'json'
require 'net/http'
require 'uri'

class Screenleap
  attr_reader :account_id, :auth_token, :uri

  def initialize(account_id, auth_token)
    @account_id = account_id
    @auth_token = auth_token
  end

  def start_presenting
    start_presenter_session
  end

  def stop_presenting
    stop_presenter_session
  end

  private

  def start_presenter_session
    @uri = URI.parse('https://api.screenleap.com/v1/screen-shares')

    perform_request
  end

  def stop_presenter_session(share_code)
    @uri = URI.parse("https://api.screenleap.com/v1/screen-shares/#{share_code}/stop")

    perform_request
  end

  def perform_request
    res = Net::HTTP.new(uri.host, uri.port).start do |http|
      http.request(request)
    end

    JSON.parse(res.body)
  end

  def request
    @req ||= create_request
  end

  def create_request
    req = Net::HTTP::Post.new(uri.path)
    req.add_field('accountid', @account_id)
    req.add_field('authtoken',@auth_token)
    req
  end

end