class LeaveRequestsController < ApplicationController
  before_action :initialize_categories, only: %i[new create]
  def index
    @requests = LeaveRequest.all
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

  private

  def leave_requests_params
    params.require(:leave_request)
          .permit(:category, :reason, :leave_start_at, :leave_end_at)
  end

  def initialize_categories
    @categories = LeaveRequest.categories
                              .map { |k, _v| [k.gsub('_', ' ').titleize, k] }
  end
end
