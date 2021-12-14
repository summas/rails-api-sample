class Api::UsersController < ApplicationController

  # 一覧取得
  def index
    render json: User.all, each_serializer: UserSerializer
  end

  # 一件取得
  def show
    user = User.find(params[:id]) rescue nil
    if user

      render json: user, each_serializer: UserSerializer
    else
      response_not_found("UsersController show params[:id]:#{params[:id]}")
    end
  end

  # 新規作成
  def create
    user = User.new(_user_params)
    puts user.inspect
    if user.save
      response_success('UsersController', 'create')
    else
      pp '----------error user create'
      response_internal_server_error  
    end
  end

  # 更新
  def update
    user = User.find(params[:id]) rescue nil

    if user and user.update(_user_params)
      response_success('UsersController', 'update')    
    else
      pp '----------error user update'
      response_not_found("UsersController update params[:id]:#{params[:id]}") 
    end
  end

  # 削除
  def destroy
    user = User.find(params[:id]) rescue nil

    if user and user.destroy
      response_success('UsersController', 'delete') 
    else
      pp '----------error user delete'
      response_not_found("UsersController delete params[:id]:#{params[:id]}")  
    end
  end

  def _user_params
    params.permit(:id, :username, :password)
  end
end
