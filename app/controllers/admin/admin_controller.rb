module Admin
  class AdminController < ApplicationController
    respond_to :html

    layout "admin"

    def index
      @meetings = Meeting.all
    end
  end
end