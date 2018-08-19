class RelationshipsController < ApplicationController
	
	#before_action :logged_in_user 

	def create
		@user = User.find(params[:id])

		if current_user.following? @user
			redirect_to user_path(@user), alert: 'Usuário já está sendo seguido'
		else
			current_user.follow! @user
			redirect_to user_path(@user), notice: 'Usuário seguido com sucesso'
		end

	#	user = User.find(params[:followed_id])
	#	current_user.follow(user)
	#	redirect_to user
	end

	def destroy
		@user = User.find(params[:id])
		current_user.unfollow!(@user)
		redirect_to user_path(@user), notice: 'Usuário deixou de ser seguido'
	end

end
