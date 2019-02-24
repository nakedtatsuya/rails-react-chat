class MessagesController < ApplicationController

  def index
    if current_user
      messages = Message.where(
          '(from_id='+current_user.id.to_s+' AND to_id='+params[:id].to_s+') OR (to_id='+current_user.id.to_s+' AND from_id='+params[:id].to_s+')'
      ).order("created_at")
      render json: messages
    else
      render status: 500, json: { status: 500, message: 'Not login. Access denied. Permission error' }
    end
  end

  def create
    if current_user
      @message = current_user.from_messages.build(message: params[:message], to_id: params[:to_id])
      if @message.save
        render json: @message
      end
    else
      render status: 500, json: { status: 500, message: 'Not login. Access denied. Permission error' }
    end

  end




  private

  def message_params
    params.require(:message).permit(:message, :from_id, :to_id)
  end
end
