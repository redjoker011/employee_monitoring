class LeaveRequestsController < ApplicationController
  before_action :initialize_categories, only: %i[new create]
  before_action :find_request, only: %i[approve decline]

  def index
    @requests = LeaveRequest.joins(:user).all
  end

  def new
    @request = LeaveRequest.new
  end

  def create
    request = current_user.leave_requests.new(leave_requests_params)

    if request.save
      redirect_to user_path(current_user), notice: "Leave Request Successfully Filed"
    else
      @request = LeaveRequest.new(leave_requests_params)
      flash[:alert] = request.errors.full_messages.to_sentence
      render :new
    end
  end

  def approve
    @request.approved!
    user = @request.user
    user.update(leave_credits: user.leave_credits - @request.leave_in_days)

    redirect_to leave_requests_path, notice: "Leave Successfully Approved"
  end

  def decline
    @request.declined!

    redirect_to leave_requests_path, notice: "Leave Successfully Declined"
  end

  private

  def leave_requests_params
    params.require(:leave_request)
          .permit(:category, :reason, :leave_start_at, :leave_end_at)
  end

  def initialize_categories
    @categories = LeaveRequest.categories
                              .map { |k, _v| [k.gsub('_', ' ').titleize, k] }
  end

  def find_request
    @request = LeaveRequest.find(params[:id])
  end
end
