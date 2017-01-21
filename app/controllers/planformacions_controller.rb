class PlanformacionsController < ApplicationController
  layout 'ly_inicio_tutor'
  before_action :set_planformacion, only: [:show, :edit, :update, :destroy]

  # GET /planformacions
  # GET /planformacions.json
  def index
    @persona = Persona.where(usuarioId: session[:usuario_id]).take
    
    @planformacions = Planformacion.where(tutorId: session[:usuario_id]).take
    #@usuarios= Usuario.all      #se quiere acceder a la informacion del usuario como el nombre, para agregarlo en la tabla pero aun no sabemos como
    #@personas= Persona.all
  end

  # GET /planformacions/1
  # GET /planformacions/1.json
  def show
  end

  # GET /planformacions/new
  def new
    @planformacion = Planformacion.new
  end

  # GET /planformacions/1/edit
  def edit
  end

  # POST /planformacions
  # POST /planformacions.json
  def create
    @planformacion = Planformacion.new(planformacion_params)

    respond_to do |format|
      if @planformacion.save
        format.html { redirect_to @planformacion, notice: 'Planformacion was successfully created.' }
        format.json { render :show, status: :created, location: @planformacion }
      else
        format.html { render :new }
        format.json { render json: @planformacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /planformacions/1
  # PATCH/PUT /planformacions/1.json
  def update
    respond_to do |format|
      if @planformacion.update(planformacion_params)
        format.html { redirect_to @planformacion, notice: 'Planformacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @planformacion }
      else
        format.html { render :edit }
        format.json { render json: @planformacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /planformacions/1
  # DELETE /planformacions/1.json
  def destroy
    @planformacion.destroy
    respond_to do |format|
      format.html { redirect_to planformacions_url, notice: 'Planformacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_planformacion
      @planformacion = Planformacion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def planformacion_params
      params.require(:planformacion).permit(:id, :fechaInicio, :fechaFin, :activo, :instructorId, :tutorId)
    end
end
