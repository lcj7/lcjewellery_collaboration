module Admin
  class MeetingsController < ApplicationController
    before_filter :authenticate_user!

    respond_to :html

    def new
      @meeting = Meeting.new
    end

    def edit
      @meeting = Meeting.find(params[:id])
    end

    def create
      session = opentok.create_session(request.ip)
      @meeting = Meeting.new(params[:meeting].merge({session_ident: session.session_id, max_size: 2}))
      @meeting.presentation = Screenleap.new.start_presenting

      if @meeting.save
        redirect_to join_meeting_path(@meeting, password: @meeting.password)
      else
        flash[:error] = "There was a problem"
        @errors = @meeting.errors
        render action: :new
      end
    end

    def update
      @meeting = Meeting.find(params[:id])

      if @meeting.update_attributes(params[:meeting])
        flash[:notice] = "Meeting was successfully updated."
        redirect_to admin_root_path
      else
        flash[:error] = "There was a problem"
        @errors = @meeting.errors
        render action: :new
      end
    end

    def destroy
      Meeting.find(params[:id]).destroy

      flash[:notice] = "Meeting successfully deleted."

      redirect_to admin_root_path
    end

    private
      def opentok
        @opentok ||= MyOpenTok.new
      end
  end
end