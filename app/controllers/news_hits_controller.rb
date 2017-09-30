class NewsHitsController < ApplicationController
  before_action :set_news_hit, only: [:show, :edit, :update, :destroy]

  # GET /news_hits
  # GET /news_hits.json
  def index
    @news_hits = NewsHit.all
  end

  # GET /news_hits/1
  # GET /news_hits/1.json
  def show
  end

  # GET /news_hits/new
  def new
    @news_hit = NewsHit.new
  end

  # GET /news_hits/1/edit
  def edit
  end

  # POST /news_hits
  # POST /news_hits.json
  def create
    @news_hit = NewsHit.new(news_hit_params)

    respond_to do |format|
      if @news_hit.save
        format.html { redirect_to @news_hit, notice: 'News hit was successfully created.' }
        format.json { render :show, status: :created, location: @news_hit }
      else
        format.html { render :new }
        format.json { render json: @news_hit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news_hits/1
  # PATCH/PUT /news_hits/1.json
  def update
    respond_to do |format|
      if @news_hit.update(news_hit_params)
        format.html { redirect_to @news_hit, notice: 'News hit was successfully updated.' }
        format.json { render :show, status: :ok, location: @news_hit }
      else
        format.html { render :edit }
        format.json { render json: @news_hit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news_hits/1
  # DELETE /news_hits/1.json
  def destroy
    @news_hit.destroy
    respond_to do |format|
      format.html { redirect_to news_hits_url, notice: 'News hit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news_hit
      @news_hit = NewsHit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_hit_params
      params.require(:news_hit).permit(:news_source_id, :keyword_id)
    end
end
