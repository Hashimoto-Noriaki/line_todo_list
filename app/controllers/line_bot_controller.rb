class LineBotController < ApplicationController
  
  def callback
    @tasks = Task.all
  end

  def show
    
  end

  def create

  end
end
