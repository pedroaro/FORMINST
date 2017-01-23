class ObservacionactividadadecuacionsController < ApplicationController
  before_action :set_observacionactividadadecuacion, only: [:show, :edit, :update, :destroy]

  # GET /observacionactividadadecuacions
  # GET /observacionactividadadecuacions.json
  def index
    @observacionactividadadecuacions = Observacionactividadadecuacion.all
  end

  # GET /observacionactividadadecuacions/1
  # GET /observacionactividadadecuacions/1.json
  def show
  end

  # GET /observacionactividadadecuacions/new
  def new
    @observacionactividadadecuacion = Observacionactividadadecuacion.new
  end

  # GET /observacionactividadadecuacions/1/edit
  def edit
  end

  # POST /observacionactividadadecuacions
  # POST /observacionactividadadecuacions.json
  def create
    @observacionactividadadecuacion = Observacionactividadadecuacion.new(observacionactividadadecuacion_params)

    respond_to do |format|
      if @observacionactividadadecuacion.save
        format.html { redirect_to @observacionactividadadecuacion, notice: 'Observacionactividadadecuacion was successfully created.' }
        format.json { render :show, status: :created, location: @observacionactividadadecuacion }
      else
        format.html { render :new }
        format.json { render json: @observacionactividadadecuacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /observacionactividadadecuacions/1
  # PATCH/PUT /observacionactividadadecuacions/1.json
  def update
    respond_to do |format|
      if @observacionactividadadecuacion.update(observacionactividadadecuacion_params)
        format.html { redirect_to @observacionactividadadecuacion, notice: 'Observacionactividadadecuacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @observacionactividadadecuacion }
      else
        format.html { render :edit }
        format.json { render json: @observacionactividadadecuacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /observacionactividadadecuacions/1
  # DELETE /observacionactividadadecuacions/1.json
  def destroy
    @observacionactividadadecuacion.destroy
    respond_to do |format|
      format.html { redirect_to observacionactividadadecuacions_url, notice: 'Observacionactividadadecuacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_observacionactividadadecuacion
      @observacionactividadadecuacion = Observacionactividadadecuacion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def observacionactividadadecuacion_params
      params.require(:observacionactividadadecuacion).permit(:id, :revisionId, :adecuacionActividadId, :observacion, :fecha)
    end
end
