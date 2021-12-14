class ApplicationController < ActionController::API
  # include ActionController::HttpAuthentication::Token::ControllerMethods

  # before_action :authenticate


  #protect_from_forgery with: :null_session
  # protect_from_forgery

  class AuthenticationError < StandardError; end

  rescue_from ActiveRecord::RecordInvalid, with: :render_422
  rescue_from AuthenticationError, with: :not_authenticated

  def authenticate
    raise AuthenticationError unless current_user
  end

  def current_user
    @current_user ||= Jwt::UserAuthenticator.call(request.headers)
  end

  private

  def render_422(exception)
    render json: { error: { messages: exception.record.errors.full_messages } }, status: :unprocessable_entity
  end

  def not_authenticated
    render json: { error: { messages: ['please login'] } }, status: :unauthorized
  end

  # 200 Success
  def response_success(class_name, action_name)
    render status: 200, json: { status: 200, message: "Success #{class_name.capitalize} #{action_name.capitalize}" }
  end

  # 400 Bad Request
  def response_bad_request
  render status: 400, json: { status: 400, message: 'Bad Request' }
  end

  # 401 Unauthorized
  def response_unauthorized
  render status: 401, json: { status: 401, message: 'Unauthorized' }
  end

  # 404 Not Found
  def response_not_found(class_name = 'page')
  render status: 404, json: { status: 404, message: "#{class_name.capitalize} Not Found" }
  end

  # 409 Conflict
  def response_conflict(class_name)
  render status: 409, json: { status: 409, message: "#{class_name.capitalize} Conflict" }
  end

  # 500 Internal Server Error
  def response_internal_server_error
  render status: 500, json: { status: 500, message: 'Internal Server Error' }
  end

  # protected
  # def authenticate
  #   authenticate_token || render_unauthorized
  # end

  # def authenticate_token
  #   pp "token　テスト authenticate_token"
  #   # authenticate_or_request_with_http_token do |token, options|
  #     authenticate_with_http_token do |token|
  #       pp "token　テスト#{authenticate_with_http_token} #{token}"
  #       Token.authenticate?(token)
  #     # pp "token　テスト#{authenticate_with_http_token} #{token} #{options}"
  #     token == 'JWT access_token'
  #   end
  # end

  # def render_unauthorized
  #   # render_errors(:unauthorized, ['invalid token'])
  #   obj = { message: 'token invalid' }
  #   render json: obj, status: :unauthorized
  # end
  # def authenticate
  #   # authenticate_or_request_with_http_token do |token, options|
  #   authenticate_with_http_token do |token, options|
  #     pp "token　テスト#{token}"
  #     token == 'ok'
  #   end
  # end
end
