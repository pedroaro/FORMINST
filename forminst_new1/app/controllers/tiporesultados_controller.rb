class TiporesultadosController < ApplicationController
  before_action :set_tiporesultado, only: [:show, :edit, :update, :destroy]

  # GET /tiporesultados
  # GET /tiporesultados.json
  def index
    @tiporesultados = Tiporesultado.all
  end

  # GET /tiporesultados/1
  # GET /tiporesultados/1.json
  def show
  end

  # GET /tiporesultados/new
  def new
    @tiporesultado = Tiporesultado.new
  end

  # GET /tiporesultados/1/edit
  def edit
  end

  # POST /tiporesultados
  # POST /tiporesultados.json
  def create
    @tiporesultado = Tiporesultado.new(tiporesultado_params)

    respond_to do |format|
      if @tiporesultado.save
        format.html { redirect_to @tiporesultado, notice: 'Tiporesultado was successfully created.' }
        format.json { render :show, status: :created, location: @tiporesultado }
      else
        format.html { render :new }
        format.json { render json: @tiporesultado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tiporesultados/1
  # PATCH/PUT /tiporesultados/1.json
  def update
    respond_to do |format|
      if @tiporesultado.update(tiporesultado_params)
        format.html { redirect_to @tiporesultado, notice: 'Tiporesultado was successfully updated.' }
        format.json { render :show, status: :ok, location: @tiporesultado }
      else
        format.html { render :edit }
        format.json { render json: @tiporesultado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tiporesultados/1
  # DELETE /tiporesultados/1.json
  def destroy
    @tiporesultado.destroy
    respond_to do |format|
      format.html { redirect_to tiporesultados_url, notice: 'Tiporesultado was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tiporesultado
      @tiporesultado = Tiporesultado.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tiporesultado_params
      params.require(:tiporesultado).permit(:id, :tipoActividadId, :idPadre, :concepto)
    end
end
