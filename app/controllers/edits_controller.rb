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
    @edits = Edit.all
    @articles = TwitterDatum.all
    @ed = EditsTwitter.all
    @categories = Category.all
    @user = current_user
  end

  # GET /edits/1
  # GET /edits/1.json
  def show
    $twiGetId = Array.new
  end

  # GET /edits/new
  def new
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
  end

  # GET /edits/1/edit
  def edit
    @trend = Trend.find(@edit.trend_id)
  end

  # POST /edits
  # POST /edits.json
  def create
    #クリエイト画面の際に配列を初期化
    $twiGetId = Array.new
    @edit = Edit.new(edit_params)
    @articles = TwitterDatum.all.order(created_at: 'desc')
# format.json { render json: @edit.errors, status: :unprocessable_entity }
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

# ドラッグアンドドロップされた時に呼ばれる
  def add
    $twiGetId << params[:id]
    $twiGetId.uniq!
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def edit_params
      params.require(:edit).permit(:title, :date, :category_id, :text, :url, { :twitter_datum_ids=> [] }, :trend_id, :User_id)
    end
end
