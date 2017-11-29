class ParticleInstancesController < ApplicationController
  before_action :set_particle_instance, only: [:show, :edit, :update, :destroy]

  # GET /particle_instances
  # GET /particle_instances.json
  def index
    @particle_instances = ParticleInstance.all
  end

  # GET /particle_instances/1
  # GET /particle_instances/1.json
  def show
  end

  # GET /particle_instances/new
  def new
    @particle = ParticleInstance.new
  end

  # GET /particle_instances/1/edit
  def edit
  end

  # POST /particle_instances
  # POST /particle_instances.json
  def create
    @particle = ParticleInstance.new(particle_params)

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

  # PATCH/PUT /particle_instances/1
  # PATCH/PUT /particle_instances/1.json
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

  # DELETE /particle_instances/1
  # DELETE /particle_instances/1.json
  def destroy
    @particle.destroy
    respond_to do |format|
      format.html { redirect_to particle_instances_url, notice: 'Particle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_particle
      @particle = ParticleInstance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def particle_params
      params.require(:particle).permit(:name, :particle_id)
    end
end
