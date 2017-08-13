class LandingController < ApplicationController

  def startworker
    Delayed::Job.enqueue(EventListener.new())
    flash[:notice] = "Test run successfully created"
    redirect_to root_path
  end

  def index
  end
end
