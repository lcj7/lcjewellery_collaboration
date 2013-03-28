class MeetingsController < ApplicationController
  respond_to :html

  before_filter :assign_meeting
  before_filter :restrict, only: :join

  def enter_password
  end

  def join
    @api_key = MyOpenTok::API_KEY
    @token = MyOpenTok.new.generate_token(@meeting.session_ident)

    @json = Screenleap.new.start_presenting
    @applet = @json["appletHtml"]

    @viewerUrl = @json["viewerUrl"]
    render :join
  end

  private

  def restrict
    if @meeting.is_locked
      unless password_matches?
        redirect_to unauthorized_path
      end
    end
  end

  def password_matches?
    params[:password] == @meeting.password
  end

  def assign_meeting
    @meeting = Meeting.find(params[:id])
  end
end