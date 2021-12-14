class PostsController < ApplicationController

  # 一覧取得　or　一件取得
  def index
    if !params[:id] then
      render plain: Post.all.to_json
    else
      post = Post.find(params[:id]) rescue nil
      if post
        render plain: post.to_json
      else
        response_not_found("PostsController index params[:id]:#{params[:id]}")
      end
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
  def delete
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
