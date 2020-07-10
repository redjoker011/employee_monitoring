class UsersController < ApplicationController
  before_action :initialize_roles, only: %i[new create]

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
      redirect_to admins_path, notice: 'User Successfully Created'
    else
      flash[:alert] = user.errors.full_messages.to_sentence
      render :new
    end
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
    @roles = User.roles.map { |k, _v| [k, k] }
  end
end
