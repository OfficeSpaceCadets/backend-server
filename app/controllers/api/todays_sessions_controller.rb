class Api::TodaysSessionsController < ApplicationController
  def index
    render json: PairingSessionReporter.new.todays_pairs
  end
end
