class LineBotController < ApplicationController
  
  def callback
    @tasks = Task.all
    binding.pry
  end

  def show
    @task = Task.find(params[:id])
  end

  def create

  end
end
