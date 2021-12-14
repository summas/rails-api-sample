class Api::TasksController < ApplicationController
  before_action :authenticate, only: %i[create update destroy]

  # 一覧取得
  def index
    render json: Task.all, each_serializer: TaskSerializer
  end

  # 一件取得
  def show
    task = Task.find(params[:id]) rescue nil
    if task
      render json: task, each_serializer: TaskSerializer  
    else
      response_not_found("TasksController show params[:id]:#{params[:id]}")
    end
  end

  # 新規作成
  def create
    task = Task.new(_task_params)
    if task.save
      response_success('TasksController', 'create')
    else
      pp '----------error task create'
      response_internal_server_error  
    end
  end

  # 更新
  def update
    task = Task.find(params[:id]) rescue nil

    if task and task.update(_task_params)
      response_success('TasksController', 'update')  
    else
      pp '----------error task update'
      response_not_found("TasksController update params[:id]:#{params[:id]}") 
    end
  end

  # 削除
  def destroy
    task = Task.find(params[:id]) rescue nil

    if task and task.destroy
      response_success('TasksController', 'delete') 
    else
      pp '----------error task delete'
      response_not_found("TasksController delete params[:id]:#{params[:id]}")  
    end
  end

  def _task_params
    params.permit(:id, :title)
  end
end
