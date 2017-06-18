class UsersController < ApplicationController
	def add_role
		@role = Role.new
	end

	def index
		@users = User.joins(:roles).where(:roles => { :hide => false })
	end
	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			@user.create_roles(params["roles"]['id'])
			flash[:success] = "User Created successfully"
			redirect_to users_path
		else
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	private

	def user_params
		params.require(:user).permit(:first_name, :email, :last_name)
	end
end
