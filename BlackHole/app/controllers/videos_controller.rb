class VideosController < ApplicationController
	def new
		@videoUp = Video.new
	end
	def create
		@videoUp = Video.new(video_params)
		tmp_str = @videoUp.link.split('/')
		@videoUp.link = tmp_str[3].to_s
		if @videoUp.save
			flash[:success] = "Your Video Is Up"
		else
			flash[:error] = "Your Video Isn't Up"
		end
	end

	def index
		@videoAll = Video.order_by(:created_at => "desc")
	end
	
	def video_params
		params.require(:video).permit(:link, :email)
	end
end
