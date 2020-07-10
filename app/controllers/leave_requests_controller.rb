class LeaveRequestsController < ApplicationController
  def index
    @requests = LeaveRequest.all
  end
end
