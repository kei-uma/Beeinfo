class TrendsController < ApplicationController
  before_action :set_trend, only: [:show, :edit, :update, :destroy]

  # GET /trends
  # GET /trends.json
  def index
    @trends = Trend.all
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trend
      @trend = Trend.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trend_params
      params.fetch(:trend, {})
    end
end
