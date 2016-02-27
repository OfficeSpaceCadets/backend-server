class PingController < ApplicationController
  before_filter :render_404_if_unauthenticated
  before_filter :render_400_if_no_ids_given

  def create
    PairingSession.create! users: users, start_time: Time.now, end_time: Time.now
    render nothing: true, status: 201
  end

  private 

  def users
    User.where id: params[:ids]
  end

  def render_404_if_unauthenticated
    authenticate_or_request_with_http_token do |token, options|
      ApiToken.find_by(token: token).present?
    end
  end

  def render_400_if_no_ids_given
    render nothing: true, status: 400 unless params.has_key? :ids
  end
end
