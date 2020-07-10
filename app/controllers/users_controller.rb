class UsersController < ApplicationController
  before_action :initialize_roles, only: %i[new create edit update]
  before_action :find_user, only: %i[edit update destroy]

  def index
    users = User.all.where.not(id: current_user.id)

    @users = if current_user.super_admin?
               users
             else
               users.where.not(role: "super_admin")
             end
  end

  def new
    @user = User.new
  end

  def show
    @user = current_user
    @requests = @user.leave_requests
  end

  def edit
  end

  def update
    if @user.update(sanitized_user_params)
      redirect_to users_path, notice: "User Successfully Updated"
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      render :edit
    end
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
    if @user
      @user.destroy!
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
      confirm_password: params[:confirm_password],
      leave_credits: params[:leave_credits]
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

  def find_user
    @user = User.find(params[:id])
  end

  def sanitized_user_params
    params.require(:user).permit(:name, :role, :email, :leave_credits)
  end
end
