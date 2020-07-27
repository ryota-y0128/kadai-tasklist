class TasksController < ApplicationController
    before_action :require_user_logged_in
    # すべてのアクションに対してまずログインの有無が問われる
    before_action :correct_user, only: [:show, :edit, :destroy]
    def index
        if logged_in?
            @tasks = current_user.tasks.order(id: :desc)
        end 
    end 
    
    def show
        # if current_user == Task.user
         # if logged_in?
       # @task = current_user.tasks.find(params[:id])
       @task = Task.find(params[:id])
    end 
    
    def new
        # if logged_in?
        # @task = Task.new
        @task = current_user.tasks.build
    end 
    
    def create
        # @task = Task.new(task_params)
        @task = current_user.tasks.build(task_params)
        if @task.save
            flash[:success] = "タスクが登録されました"
            redirect_to @task
        else 
            flash.now[:danger] = "タスクを登録できませんでした"
            render :new
        end 
    end 
    
    def edit
        @task = Task.find(params[:id])
    end 
    
    def update
        @task = Task.find(params[:id])
        
        if @task.update(task_params)
            flash[:success] = "タスクが更新されました"
            redirect_to @task
        else
            flash.now[:danger] = "タスクを更新できませんでした"
            render :edit
        end 
    end 
    
    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        
        flash[:success] = "タスクは正常に削除されました"
        redirect_to tasks_url        
    end 
   
   private
   #strong parameter
   def task_params
       params.require(:task).permit(:content, :status)
   end
   
   def correct_user
       @task = current_user.tasks.find_by(id: params[:id])
       unless @task
           redirect_to root_url
       end 
   end 
end
