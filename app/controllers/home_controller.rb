class HomeController < ApplicationController
  respond_to :html

  def index
    @meetings = Meeting.all
  end

  def unauthorized
  end
end