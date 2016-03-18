class Api::LatestSessionController < ApplicationController
  def show
    render json: PairingSessionReporter.new.latest
  end
end
