class UsersController < ApplicationController
  before_action :initialize_roles, only: %i[new create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    unless user_params[:password] == user_params[:password]
      flash[:alert] = 'Password Should Match'
      render :new
    end

    user = User.new(user_params.reject! { |k| k == :confirm_password })
    if user.save
      redirect_to users_path, notice: 'User Successfully Created'
    else
      flash[:alert] = user.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy
    user = User.find(params[:id])

    if user
      user.destroy!
      flash[:notice] = "User Successfully Deleted"
    else
      flash[:alert] = "User Not Found"
    end
    redirect_to users_path
  end

  private

  def user_params
    {
      role: params[:role],
      name: params[:name],
      email: params[:email],
      password: params[:password],
      confirm_password: params[:confirm_password]
    }
  end

  def initialize_roles
    roles = User.roles
    user_based_roles = if current_user.super_admin?
                         roles
                       else
                         roles.reject { |k, _v| k == "super_admin" }
                       end
    @roles = user_based_roles.map { |k, _v| [k.gsub('_', ' ').titleize, k] }
  end
end
