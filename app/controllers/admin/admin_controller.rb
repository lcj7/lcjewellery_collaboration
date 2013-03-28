module Admin
  class AdminController < ApplicationController
    before_filter :authenticate_user!

    respond_to :html

    layout "admin"

    def index
      @meetings = Meeting.all
    end
  end
end