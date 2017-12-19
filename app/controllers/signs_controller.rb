class SignsController < ApplicationController
  before_action :set_sign, only: [:show, :control, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

#  layout "signs", only: [ :index ]

  # GET /signs
  # GET /signs.json
  def index
    @signs = Sign.order(order: :asc)
    #    @recent_headlines = RecentHeadline.order(created_at: :desc).limit(500)
    @recent_headlines = RecentHeadline.where(current: true).order(created_at: :desc)

    respond_to do |format|
      format.html { render layout: current_user ? "application" : "signs" }
      format.json { send_data @signs.to_json, filename: "signs.json" }
    end
  end

  # GET /signs/1
  # GET /signs/1.json
  def show
    respond_to do |format|
      format.html
      format.json
    end
  end

  # POST /signs/1
  # POST /signs/1.json
  def control
    state = params.permit([:state])[:state]
    if state
      if state == 1
        @sign.turn_on
      else
        @sign.turn_off
      end
    end

    respond_to do |format|
      format.html
      format.json {
      }
    end
  end

  # GET /signs/new
  def new
    @sign = Sign.new
  end

  # GET /signs/1/edit
  def edit
  end

  # POST /signs
  # POST /signs.json
  def create
    @sign = Sign.new(sign_params)

    @sign.picture = sign_params[:picture]

    respond_to do |format|
      if @sign.save
        format.html { redirect_to @sign, notice: 'Sign was successfully created.' }
        format.json { render :show, status: :created, location: @sign }
      else
        format.html { render :new }
        format.json { render json: @sign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /signs/1
  # PATCH/PUT /signs/1.json
  def update
    respond_to do |format|
      if @sign.update(sign_params)
        format.html { redirect_to @sign, notice: 'Sign was successfully updated.' }
        format.json { render :show, status: :ok, location: @sign }
      else
        format.html { render :edit }
        format.json { render json: @sign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /signs/1
  # DELETE /signs/1.json
  def destroy
    @sign.destroy
    respond_to do |format|
      format.html { redirect_to signs_url, notice: 'Sign was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def all_on
    respond_to do |format|
      format.json { 
        Sign.all.each do |sign|
          sign.turn_on
        end
      }
    end
  end

  def all_off
    respond_to do |format|
      format.json { 
        Sign.all.each do |sign|
          sign.turn_off
        end
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sign
      @sign = Sign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sign_params
      params.require(:sign).permit(:name, :particle_instance_id, :relay, :order)
    end
end
