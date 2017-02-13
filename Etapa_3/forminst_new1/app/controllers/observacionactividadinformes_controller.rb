class ObservacionactividadinformesController < ApplicationController
  before_action :set_observacionactividadinforme, only: [:show, :edit, :update, :destroy]

  # GET /observacionactividadinformes
  # GET /observacionactividadinformes.json
  def index
    @observacionactividadinformes = Observacionactividadinforme.all
  end

  # GET /observacionactividadinformes/1
  # GET /observacionactividadinformes/1.json
  def show
  end

  # GET /observacionactividadinformes/new
  def new
    @observacionactividadinforme = Observacionactividadinforme.new
  end

  # GET /observacionactividadinformes/1/edit
  def edit
  end

  # POST /observacionactividadinformes
  # POST /observacionactividadinformes.json
  def create
    @observacionactividadinforme = Observacionactividadinforme.new(observacionactividadinforme_params)

    respond_to do |format|
      if @observacionactividadinforme.save
        format.html { redirect_to @observacionactividadinforme, notice: 'Observacionactividadinforme was successfully created.' }
        format.json { render :show, status: :created, location: @observacionactividadinforme }
      else
        format.html { render :new }
        format.json { render json: @observacionactividadinforme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /observacionactividadinformes/1
  # PATCH/PUT /observacionactividadinformes/1.json
  def update
    respond_to do |format|
      if @observacionactividadinforme.update(observacionactividadinforme_params)
        format.html { redirect_to @observacionactividadinforme, notice: 'Observacionactividadinforme was successfully updated.' }
        format.json { render :show, status: :ok, location: @observacionactividadinforme }
      else
        format.html { render :edit }
        format.json { render json: @observacionactividadinforme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /observacionactividadinformes/1
  # DELETE /observacionactividadinformes/1.json
  def destroy
    @observacionactividadinforme.destroy
    respond_to do |format|
      format.html { redirect_to observacionactividadinformes_url, notice: 'Observacionactividadinforme was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_observacionactividadinforme
      @observacionactividadinforme = Observacionactividadinforme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def observacionactividadinforme_params
      params.require(:observacionactividadinforme).permit(:id, :informeActividadId, :revisionId, :observacion)
    end
end
