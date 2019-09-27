class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
     if @user.update_attributes(user_params)
        format.html { redirect_to edit_user_path(@user), notice: 'Updated.' }
      else
        format.html {
          flash[:alert] = "Something wrong"
          render :action => :edit
        }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit([:name, :email, :password, :profile_picture,
                                  address: [:street_address, :phone_number,
                                            :city, :state, :zip_code]])
  end
end
