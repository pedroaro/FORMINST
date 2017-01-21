class ObservaciontutorsController < ApplicationController
  before_action :set_observaciontutor, only: [:show, :edit, :update, :destroy]

  # GET /observaciontutors
  # GET /observaciontutors.json
  def index
    @observaciontutors = Observaciontutor.all
  end

  # GET /observaciontutors/1
  # GET /observaciontutors/1.json
  def show
  end

  # GET /observaciontutors/new
  def new
    @observaciontutor = Observaciontutor.new
  end

  # GET /observaciontutors/1/edit
  def edit
  end

  # POST /observaciontutors
  # POST /observaciontutors.json
  def create
    @observaciontutor = Observaciontutor.new(observaciontutor_params)

    respond_to do |format|
      if @observaciontutor.save
        format.html { redirect_to @observaciontutor, notice: 'Observaciontutor was successfully created.' }
        format.json { render :show, status: :created, location: @observaciontutor }
      else
        format.html { render :new }
        format.json { render json: @observaciontutor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /observaciontutors/1
  # PATCH/PUT /observaciontutors/1.json
  def update
    respond_to do |format|
      if @observaciontutor.update(observaciontutor_params)
        format.html { redirect_to @observaciontutor, notice: 'Observaciontutor was successfully updated.' }
        format.json { render :show, status: :ok, location: @observaciontutor }
      else
        format.html { render :edit }
        format.json { render json: @observaciontutor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /observaciontutors/1
  # DELETE /observaciontutors/1.json
  def destroy
    @observaciontutor.destroy
    respond_to do |format|
      format.html { redirect_to observaciontutors_url, notice: 'Observaciontutor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_observaciontutor
      @observaciontutor = Observaciontutor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def observaciontutor_params
      params.require(:observaciontutor).permit(:id, :informeActividadId, :observacion, :fecha, :actual)
    end
end
