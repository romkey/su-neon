class ParticlesController < ApplicationController
  before_action :set_particle, only: [:show, :edit, :update, :destroy]

  # GET /particles
  # GET /particles.json
  def index
    @particles = Particle.all
  end

  # GET /particles/1
  # GET /particles/1.json
  def show
  end

  # GET /particles/new
  def new
    @particle = Particle.new
  end

  # GET /particles/1/edit
  def edit
  end

  # POST /particles
  # POST /particles.json
  def create
    @particle = Particle.new(particle_params)

    respond_to do |format|
      if @particle.save
        format.html { redirect_to @particle, notice: 'Particle was successfully created.' }
        format.json { render :show, status: :created, location: @particle }
      else
        format.html { render :new }
        format.json { render json: @particle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /particles/1
  # PATCH/PUT /particles/1.json
  def update
    respond_to do |format|
      if @particle.update(particle_params)
        format.html { redirect_to @particle, notice: 'Particle was successfully updated.' }
        format.json { render :show, status: :ok, location: @particle }
      else
        format.html { render :edit }
        format.json { render json: @particle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /particles/1
  # DELETE /particles/1.json
  def destroy
    @particle.destroy
    respond_to do |format|
      format.html { redirect_to particles_url, notice: 'Particle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_particle
      @particle = Particle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def particle_params
      params.require(:particle).permit(:name, :particle_id)
    end
end
