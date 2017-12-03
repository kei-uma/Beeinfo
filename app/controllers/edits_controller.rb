class EditsController < ApplicationController
  before_action :set_edit, only: [:show, :edit, :update, :destroy]
helper_method :twitter_datum_ids
$twiGetId = Array.new
$t = 0
  require 'date'
  # GET /edits
  # GET /edits.json
  def index
    $twiGetId = Array.new
    @edits = Edit.includes(:User).includes(:category)
    @articles = TwitterDatum.all
    @ed = EditsTwitter.all
    @categories = Category.all
    @user = current_user
    #今日の日付が取れないので昨日+1で対応
    @trends = Trend.where('updated_at > ?', DateTime.yesterday+1)
  end

  # GET /edits/1
  # GET /edits/1.json
  def show
    $twiGetId = Array.new
    @twes = @edit.edits_twitters.includes(:twitter_datum)
  end

  # GET /edits/new
  def new
    $twiGetId = Array.new
    #ページが再読み込みされるのでパラメータを保持
    if params[:select_trend] == nil
      params[:select_trend] = $t
    else
      $t = params[:select_trend]
    end
    @edit = Edit.new
    @edits = Edit.all
    @articles = TwitterDatum.all.order(created_at: 'desc')
    @trend = Trend.find(params[:select_trend])
    @arts = @trend.trend_twitters.includes(:twitter_datum)
  end

  # GET /edits/1/edit
  def edit
    $twiGetId = Array.new
    @trend = Trend.find(@edit.trend_id)
  end

  # ドラッグアンドドロップされた時に呼ばれる
    def add
      $twiGetId << params[:id]
      $twiGetId.uniq!
      logger.debug("Log1 : " + $twiGetId.to_s)
      end

  # POST /edits
  # POST /edits.json
  def create
    @edit = Edit.new(edit_params)
    @edit.twitter_datum_ids = $twiGetId
    logger.debug("Log2 : " + $twiGetId.to_s)
    @articles = TwitterDatum.all.order(created_at: 'desc')
    respond_to do |format|
      if @edit.save!
        format.html { redirect_to @edit, notice: 'Edit was successfully created.' }
        format.json { render :show, status: :created, location: @edit }
      else
        format.html { render :new }
        format.json { render json: @edit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /edits/1
  # PATCH/PUT /edits/1.json
  def update
    respond_to do |format|
      if @edit.update(edit_params)
        format.html { redirect_to @edit, notice: 'Edit was successfully updated.' }
        format.json { render :show, status: :ok, location: @edit }
      else
        format.html { render :edit }
        format.json { render json: @edit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /edits/1
  # DELETE /edits/1.json
  def destroy
    $twiGetId = Array.new
    @edit.destroy
    respond_to do |format|
      format.html { redirect_to edits_url, notice: 'Edit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_edit
      $twiGetId = Array.new
      @edit = Edit.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def edit_params
      $twiGetId = Array.new
      params.require(:edit).permit(:title, :date, :category_id, :text, :url, { :twitter_datum_ids=> [] }, :trend_id, :User_id)
    end
end
