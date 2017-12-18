class TrendsController < ApplicationController
  before_action :set_trend, only: [:show, :edit, :update, :destroy]
  before_action :isauth, only: [:index]
  # GET /trends
  # GET /trends.json
  def index
    @trends = Trend.all.order(created_at: 'desc')
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trend
      @trend = Trend.find(params[:id])
    end

    def isauth
      unless current_user.authority
        redirect_to current_user
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def trend_params
      params.fetch(:trend, {})
    end
end
