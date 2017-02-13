class EstatusadecuacionsController < ApplicationController
  before_action :set_estatusadecuacion, only: [:show, :edit, :update, :destroy]

  # GET /estatusadecuacions
  # GET /estatusadecuacions.json
  def index
    @estatusadecuacions = Estatusadecuacion.all
  end

  # GET /estatusadecuacions/1
  # GET /estatusadecuacions/1.json
  def show
  end

  # GET /estatusadecuacions/new
  def new
    @estatusadecuacion = Estatusadecuacion.new
  end

  # GET /estatusadecuacions/1/edit
  def edit
  end

  # POST /estatusadecuacions
  # POST /estatusadecuacions.json
  def create
    @estatusadecuacion = Estatusadecuacion.new(estatusadecuacion_params)

    respond_to do |format|
      if @estatusadecuacion.save
        format.html { redirect_to @estatusadecuacion, notice: 'Estatusadecuacion was successfully created.' }
        format.json { render :show, status: :created, location: @estatusadecuacion }
      else
        format.html { render :new }
        format.json { render json: @estatusadecuacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /estatusadecuacions/1
  # PATCH/PUT /estatusadecuacions/1.json
  def update
    respond_to do |format|
      if @estatusadecuacion.update(estatusadecuacion_params)
        format.html { redirect_to @estatusadecuacion, notice: 'Estatusadecuacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @estatusadecuacion }
      else
        format.html { render :edit }
        format.json { render json: @estatusadecuacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /estatusadecuacions/1
  # DELETE /estatusadecuacions/1.json
  def destroy
    @estatusadecuacion.destroy
    respond_to do |format|
      format.html { redirect_to estatusadecuacions_url, notice: 'Estatusadecuacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_estatusadecuacion
      @estatusadecuacion = Estatusadecuacion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def estatusadecuacion_params
      params.require(:estatusadecuacion).permit(:id, :adecuacionId, :fecha, :estatusId, :actual)
    end
end
