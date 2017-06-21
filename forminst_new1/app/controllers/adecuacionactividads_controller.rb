class AdecuacionactividadsController < ApplicationController
  before_action :set_adecuacionactividad, only: [:show, :edit, :update, :destroy]

  # GET /adecuacionactividads
  # GET /adecuacionactividads.json
  def index
    @adecuacionactividads = Adecuacionactividad.all
  end

  # GET /adecuacionactividads/1
  # GET /adecuacionactividads/1.json
  def show
  end

  # GET /adecuacionactividads/new
  def new
    @adecuacionactividad = Adecuacionactividad.new
  end

  # GET /adecuacionactividads/1/edit
  def edit
  end

  # POST /adecuacionactividads
  # POST /adecuacionactividads.json
  def create
    @adecuacionactividad = Adecuacionactividad.new(adecuacionactividad_params)

    respond_to do |format|
      if @adecuacionactividad.save
        format.html { redirect_to @adecuacionactividad, notice: 'Adecuacionactividad was successfully created.' }
        format.json { render :show, status: :created, location: @adecuacionactividad }
      else
        format.html { render :new }
        format.json { render json: @adecuacionactividad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /adecuacionactividads/1
  # PATCH/PUT /adecuacionactividads/1.json
  def update
    respond_to do |format|
      if @adecuacionactividad.update(adecuacionactividad_params)
        format.html { redirect_to @adecuacionactividad, notice: 'Adecuacionactividad was successfully updated.' }
        format.json { render :show, status: :ok, location: @adecuacionactividad }
      else
        format.html { render :edit }
        format.json { render json: @adecuacionactividad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adecuacionactividads/1
  # DELETE /adecuacionactividads/1.json
  def destroy
    @adecuacionactividad.destroy
    respond_to do |format|
      format.html { redirect_to adecuacionactividads_url, notice: 'Adecuacionactividad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adecuacionactividad
      @adecuacionactividad = Adecuacionactividad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def adecuacionactividad_params
      params.require(:adecuacionactividad).permit(:id, :adecuacionId, :actividadId, :anulada, :semestre)
    end
end
