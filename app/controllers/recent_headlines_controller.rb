class RecentHeadlinesController < ApplicationController
  before_action :set_recent_headline, only: [:show, :edit, :update, :destroy]

  # GET /recent_headlines
  # GET /recent_headlines.json
  def index
    @recent_headlines = RecentHeadline.all

    respond_to do |format|
      format.html
      format.json { send_data @recent_headlines.to_json, filename: "recent-headlines.json" }
    end
  end

  # GET /recent_headlines/1
  # GET /recent_headlines/1.json
  def show
  end

  # GET /recent_headlines/new
  def new
    @recent_headline = RecentHeadline.new
  end

  # GET /recent_headlines/1/edit
  def edit
  end

  # POST /recent_headlines
  # POST /recent_headlines.json
  def create
    @recent_headline = RecentHeadline.new(recent_headline_params)

    respond_to do |format|
      if @recent_headline.save
        format.html { redirect_to @recent_headline, notice: 'Recent headline was successfully created.' }
        format.json { render :show, status: :created, location: @recent_headline }
      else
        format.html { render :new }
        format.json { render json: @recent_headline.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recent_headlines/1
  # PATCH/PUT /recent_headlines/1.json
  def update
    respond_to do |format|
      if @recent_headline.update(recent_headline_params)
        format.html { redirect_to @recent_headline, notice: 'Recent headline was successfully updated.' }
        format.json { render :show, status: :ok, location: @recent_headline }
      else
        format.html { render :edit }
        format.json { render json: @recent_headline.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recent_headlines/1
  # DELETE /recent_headlines/1.json
  def destroy
    @recent_headline.destroy
    respond_to do |format|
      format.html { redirect_to recent_headlines_url, notice: 'Recent headline was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recent_headline
      @recent_headline = RecentHeadline.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recent_headline_params
      params.fetch(:recent_headline, {})
    end
end
