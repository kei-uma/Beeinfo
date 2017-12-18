class EditsController < ApplicationController
  before_action :set_edit, only: [:show, :edit, :update, :destroy]
  before_action :isauth, only: [:index]
helper_method :twitter_datum_ids
@@user_data = {}
@@t = 0
  require 'date'
  # GET /edits
  # GET /edits.json

  def index
    @user = current_user
    @edits = Edit.includes(:User).includes(:category)
    @articles = TwitterDatum.all.order(created_at: 'desc')
    @ed = EditsTwitter.all.order(created_at: 'desc')
    @categories = Category.all
    #今日の日付が取れないので昨日+1で対応
    @trends = Trend.where('updated_at > ?', DateTime.yesterday+1)
  end

  # GET /edits/1
  # GET /edits/1.json
  def show
    @categories = Category.all

    @twes = @edit.edits_twitters.includes(:twitter_datum)
  end

  # GET /edits/new
  def new

    logger.debug("Log0 : " + @@user_data[params[:user_id]].to_s)
    #ページが再読み込みされるのでパラメータを保持
    if params[:select_trend] == nil
      params[:select_trend] = @@t
    else
      @@t = params[:select_trend]
    end
    @edit = Edit.new
    @edits = Edit.all
    @articles = TwitterDatum.all.order(created_at: 'desc')
    @trend = Trend.find(params[:select_trend])
    @arts = @trend.trend_twitters.includes(:twitter_datum)
  end

  # GET /edits/1/edit
  def edit
    @trend = Trend.find(@edit.trend_id)
  end

  # ドラッグアンドドロップされた時に呼ばれる
  def add
    @@user_data[params[:user_id]] = params[:id]
    logger.debug("Log5 : " + @@user_data[params[:user_id]].to_s)
    logger.debug("Log1 : " + params[:id].to_s)
    @@user_data[params[:user_id]].uniq!
    logger.debug("Log1 : " + @@user_data[params[:user_id]].to_s)
hash = {id: @@user_data[params[:user_id]]}
require 'json'
render :json => hash.to_json
  end

  #GET /edits/list
  def list
    @q = Edit.includes(:User).ransack(params[:q])
    @edits = @q.result(distinct: true).order(created_at: 'desc')
    @user = current_user
  end

  # POST /edits
  # POST /edits.json
  def create
    @edit = Edit.new(edit_params)
    # current_user.idを取得
    cui = current_user.id.to_s
    @edit.twitter_datum_ids =  @@user_data[cui]
    logger.debug("Log6 : " + current_user.id.to_s)
    logger.debug(@edit.twitter_datum_ids)
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
    @edit.destroy
    respond_to do |format|
      format.html { redirect_to edits_url, notice: 'Edit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_edit
      @edit = Edit.find_by_id(params[:id])
    end

    def isauth
      unless current_user.authority
        redirect_to current_user
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def edit_params
      logger.debug("Log3 : " + @@user_data[params[:user_id]].to_s)
      params.require(:edit).permit(:title, :date, :category_id, :text, :url, :trend_id, :User_id)
    end
end
