class MessagesController < ApplicationController
    def create
        @message=current_user.messages.create(body:msg_params[:body], room_id: params[:room_id])
        if @message.save
            flash.now[:notice] = 'Message sent!'
          else
            flash.now[:alert] = 'Error while sending message!'
          end
        
    end
    private

    def msg_params
            params.require(:message).permit(:body)
    end
end
