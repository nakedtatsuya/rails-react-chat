class MessagesController < ApplicationController

  def index
      messages = Message.where(
          '(from_id='+current_user.id.to_s+' AND to_id='+params[:id].to_s+') OR (to_id='+current_user.id.to_s+' AND from_id='+params[:id].to_s+')'
      ).order("created_at")
      messages.where(to_id: current_user.id).update_all(is_read: true)
      render json: messages
  end

  def create
    @message = current_user.from_messages.build(message: params[:message], to_id: params[:to_id])
    if @message.save
      render json: @message
    end
  end

  def image
      @message = current_user.from_messages.build(image: params[:image], to_id: params[:to_id])
      if @message.save
        render json: @message
      end
  end

  private

  def message_params
    params.require(:message).permit(:message, :from_id, :to_id, :image)
  end
end
