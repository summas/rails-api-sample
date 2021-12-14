class Api::PostsController < ApplicationController
  before_action :authenticate, only: %i[create update destroy]

  # 一覧取得
  def index
    render json: Post.all, each_serializer: PostSerializer  
  end

  # 一件取得
  def show
    post = Post.find(params[:id]) rescue nil
    if post
      render json: post, each_serializer: PostSerializer  
    else
      response_not_found("PostsController show params[:id]:#{params[:id]}")
    end
  end

  # 新規作成
  def create
    post = Post.new(_post_params)
    if post.save
      response_success('PostsController', 'create')
    else
      pp '----------error post create'
      response_internal_server_error
    end
  end

  # 更新
  def update
    post = Post.find(params[:id]) rescue nil

    if post and post.update(_post_params)
      response_success('PostsController', 'update')  
    else
      pp '----------error post update'
      response_not_found("PostsController update params[:id]:#{params[:id]}")  
    end
  end

  # 削除
  def destroy
    post = Post.find(params[:id]) rescue nil

    if post and post.destroy
      response_success('PostsController', 'delete')    
    else
      pp '----------error delete delete'
      response_not_found("PostsController delete params[:id]:#{params[:id]}")  
    end
  end

  private

  def _post_params
    params.permit(:id, :title, :content)
  end
end
