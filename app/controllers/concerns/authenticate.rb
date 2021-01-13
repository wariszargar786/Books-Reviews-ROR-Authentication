module Authenticate
  def current_user
    auth_token = request.headers["AUTH-TOKEN"]
    return unless auth_token
    @current_user = User.where(authentication_token: auth_token).first
  end

  def authenticate_with_token
    return if current_user
    json_response "Un-Authenticated", false ,{}, :unauthorized
  end
  def correct_current_user user
    user.id == current_user.id
  end
end