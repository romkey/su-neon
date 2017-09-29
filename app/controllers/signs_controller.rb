class SignsController < ApplicationController
  before_action :set_sign, only: [:show, :edit, :update, :destroy]

  # GET /signs
  # GET /signs.json
  def index
    @signs = Sign.order(name: :asc)
  end

  # GET /signs/1
  # GET /signs/1.json
  def show
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sign
      @sign = Sign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sign_params
      params.require(:sign).permit(:name, :particle_instance_id, :relay, :picture)
    end
end
