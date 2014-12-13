class MessagesController < ApplicationController
	def new
		@message = Message.new
	end
	def create
		@message = Message.new(message_params)
		if @message.save
			flash[:success] = "Your Message Is Send"
      		redirect_to root_path
		else
		end
	end
	
	def message_params
		params.require(:message).permit(:email, :topic, :msg)
	end
end
