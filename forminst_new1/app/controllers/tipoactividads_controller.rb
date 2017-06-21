class TipoactividadsController < ApplicationController
  before_action :set_tipoactividad, only: [:show, :edit, :update, :destroy]

  # GET /tipoactividads
  # GET /tipoactividads.json
  def index
    @tipoactividads = Tipoactividad.all
  end

  # GET /tipoactividads/1
  # GET /tipoactividads/1.json
  def show
  end

  # GET /tipoactividads/new
  def new
    @tipoactividad = Tipoactividad.new
  end

  # GET /tipoactividads/1/edit
  def edit
  end

  # POST /tipoactividads
  # POST /tipoactividads.json
  def create
    @tipoactividad = Tipoactividad.new(tipoactividad_params)

    respond_to do |format|
      if @tipoactividad.save
        format.html { redirect_to @tipoactividad, notice: 'Tipoactividad was successfully created.' }
        format.json { render :show, status: :created, location: @tipoactividad }
      else
        format.html { render :new }
        format.json { render json: @tipoactividad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipoactividads/1
  # PATCH/PUT /tipoactividads/1.json
  def update
    respond_to do |format|
      if @tipoactividad.update(tipoactividad_params)
        format.html { redirect_to @tipoactividad, notice: 'Tipoactividad was successfully updated.' }
        format.json { render :show, status: :ok, location: @tipoactividad }
      else
        format.html { render :edit }
        format.json { render json: @tipoactividad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipoactividads/1
  # DELETE /tipoactividads/1.json
  def destroy
    @tipoactividad.destroy
    respond_to do |format|
      format.html { redirect_to tipoactividads_url, notice: 'Tipoactividad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipoactividad
      @tipoactividad = Tipoactividad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipoactividad_params
      params.require(:tipoactividad).permit(:id, :concepto, :grupoActividadesId, :subGrupoActividadId)
    end
end
