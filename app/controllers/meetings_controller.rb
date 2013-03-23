class MeetingsController < ApplicationController
  respond_to :html

  def new
    @meeting = Meeting.new
  end

  def create
    session = opentok.create_session(request.ip)
    @meeting = Meeting.new(params[:meeting].merge({session_ident: session.session_id, max_size: 2}))

    if @meeting.save
      redirect_to join_meeting_path(@meeting)
    else
      flash[:error] = "There was a problem"
      @errors = @meeting.errors
      render action: :new
    end
  end

  def join
    @api_key = MyOpenTok::API_KEY
    @meeting = Meeting.find(params[:id])

    @token = opentok.generate_token(@meeting.session_ident)
  end

  def destroy
    Meeting.find(params[:id]).destroy

    redirect_to root_path
  end

private
  def opentok
    @opentok ||= MyOpenTok.new
  end
end