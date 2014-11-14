class UsersController < ApplicationController
	before_filter :correct_user, :only => [:edit, :update, :destroy]
	before_filter :authenticate, :only => [:edit, :update]
	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "Utilisateur supprimé."
		redirect_to root_path
	end
	
	def new
		@user = User.new
	end
	
	def show
		@user = User.find(params[:id])
		@titre = @user.name
	end
	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Profil actualisé."
			redirect_to @user
		else
			@titre = "Édition profil"
			render 'edit'
		end
	end
	def create
		@user = User.new(user_params)
		#raise @user.to_a.to_s
		if @user.save
			sign_in @user
			flash[:success] = "Welcome on BlackHole"
      		redirect_to @user
		else
		end
	end
	def user_params
		params.require(:user).permit(:login, :email, :name, :lastname, :encrypted_password, :salt)
	end
	def edit
    	@user = User.find(params[:id])
    	@titre = "Édit Profil"
    end
    def current_user?(user)
    	user == current_user
  	end
    def correct_user
    	@user = User.find(params[:id])
    	redirect_to(root_path) unless current_user?(@user)
    end

    def index
        @titre = "All Users"
	    @users = User.all
    end

      private

    def authenticate
      deny_access unless signed_in?
    end

end
