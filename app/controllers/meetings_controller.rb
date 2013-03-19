class MeetingsController < ApplicationController
  API_KEY = '23300482'.freeze

  def new
    @meeting = Meeting.new
  end

  def create
    session = opentok.createSession(request.ip)
    @meeting = Meeting.new(params[:meeting].merge({session_ident: session.session_id}))

    if @meeting.save
      redirect_to join_meeting_path(meeting)
    else
      flash[:error] = "There was a problem"
      @errors = @meeting.errors
      render action: :new
    end
  end

  def join
    @api_key = API_KEY
    @meeting = Meeting.find(params[:id])

    @token = opentok.generateToken session_id: @meeting.session_ident
  end

  def destroy
    Meeting.find(params[:id]).destroy

    redirect_to root_path
  end

private

  def opentok
    @opentok ||= OpenTok::OpenTokSDK.new API_KEY, '55f3cbd9ba275405d8dbaa7307611dfcb9f60a78'
  end

end