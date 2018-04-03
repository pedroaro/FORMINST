class InformeactividadsController < ApplicationController
  before_action :set_informeactividad, only: [:show, :edit, :update, :destroy]

  # GET /informeactividads
  # GET /informeactividads.json
  def index
    @informeactividads = Informeactividad.all
  end

  # GET /informeactividads/1
  # GET /informeactividads/1.json
  def show
  end

  # GET /informeactividads/new
  def new
    @informeactividad = Informeactividad.new
  end

  # GET /informeactividads/1/edit
  def edit
  end

  # POST /informeactividads
  # POST /informeactividads.json
  def create
    @informeactividad = Informeactividad.new(informeactividad_params)

    respond_to do |format|
      if @informeactividad.save
        format.html { redirect_to @informeactividad, notice: 'Informeactividad was successfully created.' }
        format.json { render :show, status: :created, location: @informeactividad }
      else
        format.html { render :new }
        format.json { render json: @informeactividad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /informeactividads/1
  # PATCH/PUT /informeactividads/1.json
  def update
    respond_to do |format|
      if @informeactividad.update(informeactividad_params)
        format.html { redirect_to @informeactividad, notice: 'Informeactividad was successfully updated.' }
        format.json { render :show, status: :ok, location: @informeactividad }
      else
        format.html { render :edit }
        format.json { render json: @informeactividad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /informeactividads/1
  # DELETE /informeactividads/1.json
  def destroy
    @informeactividad.destroy
    respond_to do |format|
      format.html { redirect_to informeactividads_url, notice: 'Informeactividad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_informeactividad
      @informeactividad = Informeactividad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def informeactividad_params
      params.require(:informeactividad).permit(:id, :informeId, :actividadId)
    end
end
