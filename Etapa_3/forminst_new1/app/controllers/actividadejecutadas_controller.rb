class ActividadejecutadasController < ApplicationController
  before_action :set_actividadejecutada, only: [:show, :edit, :update, :destroy]

  # GET /actividadejecutadas
  # GET /actividadejecutadas.json
  def index
    @actividadejecutadas = Actividadejecutada.all
  end

  # GET /actividadejecutadas/1
  # GET /actividadejecutadas/1.json
  def show
  end

  # GET /actividadejecutadas/new
  def new
    @actividadejecutada = Actividadejecutada.new
  end

  # GET /actividadejecutadas/1/edit
  def edit
  end

  # POST /actividadejecutadas
  # POST /actividadejecutadas.json
  def create
    @actividadejecutada = Actividadejecutada.new(actividadejecutada_params)

    respond_to do |format|
      if @actividadejecutada.save
        format.html { redirect_to @actividadejecutada, notice: 'Actividadejecutada was successfully created.' }
        format.json { render :show, status: :created, location: @actividadejecutada }
      else
        format.html { render :new }
        format.json { render json: @actividadejecutada.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /actividadejecutadas/1
  # PATCH/PUT /actividadejecutadas/1.json
  def update
    respond_to do |format|
      if @actividadejecutada.update(actividadejecutada_params)
        format.html { redirect_to @actividadejecutada, notice: 'Actividadejecutada was successfully updated.' }
        format.json { render :show, status: :ok, location: @actividadejecutada }
      else
        format.html { render :edit }
        format.json { render json: @actividadejecutada.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /actividadejecutadas/1
  # DELETE /actividadejecutadas/1.json
  def destroy
    @actividadejecutada.destroy
    respond_to do |format|
      format.html { redirect_to actividadejecutadas_url, notice: 'Actividadejecutada was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_actividadejecutada
      @actividadejecutada = Actividadejecutada.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def actividadejecutada_params
      params.require(:actividadejecutada).permit(:id, :descripcion, :fecha, :actual, :informeActividadId)
    end
end
