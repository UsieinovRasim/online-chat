class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    @new_room = Room.new
  end

  def show
    @room = Room.find(params[:id])
    # @room = Room.find_by!(title: params[:title])
    @messages = @room.messages.includes(:user)
    # @messages = MessageDecorator.decorate_collection(@room.messages.includes(:user))
    @new_message = current_user&.messages&.build(room: @room)
  end

  def create
    @new_room = Room.new(title: params[:room][:title], user: current_user)

    if @new_room.save
      @new_room.broadcast_append_to :rooms
    end
  end
end
