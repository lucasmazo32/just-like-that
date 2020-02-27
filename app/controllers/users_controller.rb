class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit delete]
  before_action :not_logged, except: %i[new create]
  before_action :param_check, only: %i[index]

  def me
    redirect_to me_path(current_user)
  end

  def show
    @user = User.friendly.find(params[:id])
    @users = @user.opinions.paginate(page: params[:page])
  end

  def index
    @user = User.find_by(username: params[:user])
    return @users = search_param(params[:q]).paginate(page: params[:page]) unless params[:q].nil?

    case params[:follow]
    when 'followers'
      @users = @user.followers.paginate(page: params[:page])
    when 'following'
      @users = @user.following.paginate(page: params[:page])
    when 'popular accounts'
      @users = User.where(id: popular).paginate(page: params[:page])
    when 'find friends'
      @users = User.where.not(id: find_friends(current_user)).paginate(page: params[:page])
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to me_path(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.friendly.find(params[:id])
  end

  def update
    @user = User.friendly.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to me_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.friendly.find(params[:id])
    @user.destroy
    flash[:danger] = 'User deleted'
    redirect_to login_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :photo, :coverimage)
  end

  def set_user
    @user = User.friendly.find(params[:id])
    redirect_to action: action_name, id: @user.friendly_id, status: 301 unless @user.friendly_id == params[:id]
  end

  def param_check
    redirect_to root_path if params[:user].nil?
  end
end