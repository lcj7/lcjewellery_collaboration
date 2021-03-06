require 'json'
require 'net/http'
require 'uri'

class Screenleap
  attr_reader :account_id, :auth_token, :uri

  ACCOUNT_ID = 'lcjewelleryCollaboration'.freeze
  AUTH_TOKEN = 'YfWVIZCPVJ'.freeze

  def initialize
    @account_id = ACCOUNT_ID
    @auth_token = AUTH_TOKEN
  end

  def start_presenting
    start_presenter_session
  end

  def stop_presenting(share_code)
    stop_presenter_session(share_code)
  end

  private

  def start_presenter_session
    @uri = URI.parse('http://api.screenleap.com/v1/screen-shares')

    request_result = perform_request

    Presentation.new(
                      {
                        viewer_url: request_result['viewerUrl'],
                        share_code: request_result['screenShareCode'],
                        applet_html: request_result['appletHtml'],
                        participant_id: request_result['participantId']
                      }
                    )
  end

  def stop_presenter_session(share_code)
    @uri = URI.parse("http://api.screenleap.com/v1/screen-shares/#{share_code}/stop")

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