class TasksController < ApplicationController

  # 一覧取得　or　一件取得
  def index
    if !params[:id] then
      render plain: Task.all.to_json
    else
      task = Task.find(params[:id]) rescue nil
      if task
        render plain: task.to_json
      else
        response_not_found("TasksController index params[:id]:#{params[:id]}")
      end
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
      render plain: {status:'success'}.to_json    
    else
      pp '----------error task update'
      response_not_found("TasksController update params[:id]:#{params[:id]}") 
    end
  end

  # 削除
  def delete
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
