class RolesController < ApplicationController
	def new
		@role = Role.new
	end

	def create
		@role = Role.create(name: params[:role][:name], hide: false)
		redirect_to root_path, notice: "Role created successfully"
	end

	def index
		@roles = Role.all
	end

	def hide_roles
		role_ids = params[:role_ids]
		if role_ids
			Role.hide_roles(role_ids)
		else
			Role.all.update_all(hide: false)
		end

		redirect_to roles_path, notice: "Roles hided successfully"
	end
end
