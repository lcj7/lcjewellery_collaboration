class MeetingsController < ApplicationController
  respond_to :html

  def join
    @api_key = MyOpenTok::API_KEY
    @meeting = Meeting.find(params[:id])

    @token = MyOpenTok.new.generate_token(@meeting.session_ident)
  end
end