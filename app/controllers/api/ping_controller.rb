class Api::PingController < Api::BaseController
  before_filter :render_404_if_unauthenticated, :render_400_if_no_ids_given, :render_404_if_users_dont_exist

  def create
    PairingSessionHandler.new(params[:ids]).create_or_update_session
    render nothing: true, status: 201
  end

  private 

  def render_404_if_users_dont_exist
    render nothing: true, status: 404 unless users_exist?
  end

  def render_404_if_unauthenticated
    authenticate_or_request_with_http_token do |token, options|
      ApiToken.find_by(token: token).present?
    end
  end

  def render_400_if_no_ids_given
    render nothing: true, status: 400 unless params.has_key? :ids
  end

  def users_exist?
    User.where(external_id: params[:ids]).length == params[:ids].length
  end
end
