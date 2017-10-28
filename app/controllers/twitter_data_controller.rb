class TwitterDataController < ApplicationController
  before_action :set_twitter_datum, only: [:show, :edit, :update, :destroy]

  # GET /twitter_data
  # GET /twitter_data.json
  def index
    @twitter_data = TwitterDatum.all
  end

  # GET /twitter_data/1
  # GET /twitter_data/1.json
  def show
  end

  # GET /twitter_data/new
  def new
    @twitter_datum = TwitterDatum.new
  end

  # GET /twitter_data/1/edit
  def edit
  end

  # POST /twitter_data
  # POST /twitter_data.json
  def create
    @twitter_datum = TwitterDatum.new(twitter_datum_params)

    respond_to do |format|
      if @twitter_datum.save
        format.html { redirect_to @twitter_datum, notice: 'Twitter datum was successfully created.' }
        format.json { render :show, status: :created, location: @twitter_datum }
      else
        format.html { render :new }
        format.json { render json: @twitter_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /twitter_data/1
  # PATCH/PUT /twitter_data/1.json
  def update
    respond_to do |format|
      if @twitter_datum.update(twitter_datum_params)
        format.html { redirect_to @twitter_datum, notice: 'Twitter datum was successfully updated.' }
        format.json { render :show, status: :ok, location: @twitter_datum }
      else
        format.html { render :edit }
        format.json { render json: @twitter_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /twitter_data/1
  # DELETE /twitter_data/1.json
  def destroy
    @twitter_datum.destroy
    respond_to do |format|
      format.html { redirect_to twitter_data_url, notice: 'Twitter datum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_twitter_datum
      @twitter_datum = TwitterDatum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def twitter_datum_params
      params.fetch(:twitter_datum, {})
    end
end
