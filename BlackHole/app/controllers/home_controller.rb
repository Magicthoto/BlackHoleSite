class HomeController < ApplicationController
	def index
		@videoAll = Video.order_by(:created_at => "desc")
	end
end
