class RoomController < ApplicationController

  def index
    if current_user.present?
      @messages = Message.all
      render action:'show'
      return
    end
  end
  def show
    @messages = Message.all
  end
end
