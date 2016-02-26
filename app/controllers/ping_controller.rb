class PingController < ApplicationController
  before_filter :render_404_if_unauthenticated

  def create
    render nothing: true, status: 201
  end

  private 

  def render_404_if_unauthenticated
    authenticate_or_request_with_http_token do |token, options|
      ApiToken.find_by(token: token).present?
    end
  end
end
