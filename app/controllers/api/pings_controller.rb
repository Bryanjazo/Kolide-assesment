class Api::PingsController < ApplicationController
  before_action :set_api_ping, only: [:show, :update, :destroy]

  # GET /api/ping
  def get_ping 
    response = render json: {
      status: 200,
      success: true
    }
  end

end
