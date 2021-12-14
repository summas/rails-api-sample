class Api::SessionsController < ApplicationController

 def create
    user = User.find_by(username: session_params[:username])
    if user&.authenticate(session_params[:password])
      access = Jwt::TokenProvider.call(user_id: user.id)
      render json: UserSerializer.new(user).as_json.deep_merge({ access: access })
      # render json: ActiveModelSerializers::SerializableResource.new(user, serializer: UserSerializer).as_json.deep_merge(user: { token: token })
    else
      # render json: { error: { messages: ['mistake password or something'] } }, status: :unauthorized
      render json: { error: { messages: ['mistake password or something'] , data: "#{session_params[:id]} #{session_params[:username]} #{session_params[:password]}" } }, status: :unauthorized
    end
  end

  private

  def session_params
    params.require(:session).permit(:id, :username, :password)
  end
end
