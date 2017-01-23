class UsuarioentidadsController < ApplicationController
  before_action :set_usuarioentidad, only: [:show, :edit, :update, :destroy]

  # GET /usuarioentidads
  # GET /usuarioentidads.json
  def index
    @usuarioentidads = Usuarioentidad.all
  end

  # GET /usuarioentidads/1
  # GET /usuarioentidads/1.json
  def show
  end

  # GET /usuarioentidads/new
  def new
    @usuarioentidad = Usuarioentidad.new
  end

  # GET /usuarioentidads/1/edit
  def edit
  end

  # POST /usuarioentidads
  # POST /usuarioentidads.json
  def create
    @usuarioentidad = Usuarioentidad.new(usuarioentidad_params)

    respond_to do |format|
      if @usuarioentidad.save
        format.html { redirect_to @usuarioentidad, notice: 'Usuarioentidad was successfully created.' }
        format.json { render :show, status: :created, location: @usuarioentidad }
      else
        format.html { render :new }
        format.json { render json: @usuarioentidad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usuarioentidads/1
  # PATCH/PUT /usuarioentidads/1.json
  def update
    respond_to do |format|
      if @usuarioentidad.update(usuarioentidad_params)
        format.html { redirect_to @usuarioentidad, notice: 'Usuarioentidad was successfully updated.' }
        format.json { render :show, status: :ok, location: @usuarioentidad }
      else
        format.html { render :edit }
        format.json { render json: @usuarioentidad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarioentidads/1
  # DELETE /usuarioentidads/1.json
  def destroy
    @usuarioentidad.destroy
    respond_to do |format|
      format.html { redirect_to usuarioentidads_url, notice: 'Usuarioentidad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usuarioentidad
      @usuarioentidad = Usuarioentidad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usuarioentidad_params
      params.require(:usuarioentidad).permit(:id, :usuarioId, :entidadesId)
    end
end
