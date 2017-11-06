class EditsController < ApplicationController
  before_action :set_edit, only: [:show, :edit, :update, :destroy]
helper_method :twitter_datum_ids
$twiGetId = Array.new
  require 'date'
  # GET /edits
  # GET /edits.json
  def index
    $twiGetId = Array.new
    @edits = Edit.all
    @articles = TwitterDatum.all
    @ed = EditsTwitter.all
 # 	 @articles = TwitterDatum.all.order(created_at: 'asc')
    @categories = Category.all
 	 #@articles = TwitterDatum.all.order(created_at: 'desc')g

  end

  # GET /edits/1
  # GET /edits/1.json
  def show
    $twiGetId = Array.new
  end

  # GET /edits/new
  def new
    @edit = Edit.new
    @edits = Edit.all
    @articles = TwitterDatum.all.order(created_at: 'desc')
 	 #@articles = TwitterDatum.all.order(created_at: 'desc')
  end

  # GET /edits/1/edit
  def edit
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
    # @getEdit = Edit.all.order(created_at: 'desc')
# @edit = Edit.new(params[:id])
# @edits[twitter_datum_ids] << selected_user.user_id
#twitter_datum_ids << params[:id]
#  hash = {id: twitter_datum_ids}
#  require 'json'
#  render :json => hash.to_json
  # twi = EditsTwitter.new
  #   twi.twitter_datum_id = params[:id]
  #   @getEdit.each do |getedit|

  #  edits_id = @getedit.id + 1

  # end
    # twi.edit_id = 36
    # if twi.save #上の処理をするといらない
    #   #head 201
    #   user = TwitterDatum.find(twi.twitter_datum_id)
    #   #ここの値がdataに入る
    #   hash = {id: user.id, user: user.user,tweet: user.tweet}
    #   require 'json'
    #   render :json => hash.to_json
    # else
    #   head 500
    # end

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
      # params.require(:edit).permit(:user, :title, :date, { :twitter_datum_ids=> [] }, :category_id, :text, :url)
      params.require(:edit).permit(:user, :title, :date, :category_id, :text, :url ,{ :twitter_datum_ids=> [] })

    end
end
