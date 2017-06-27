class TipoestatusesController < ApplicationController
  before_action :set_tipoestatus, only: [:show, :edit, :update, :destroy]

  # GET /tipoestatuses
  # GET /tipoestatuses.json
  def index
    @tipoestatuses = Tipoestatus.all
  end

  # GET /tipoestatuses/1
  # GET /tipoestatuses/1.json
  def show
  end

  # GET /tipoestatuses/new
  def new
    @tipoestatus = Tipoestatus.new
  end

  # GET /tipoestatuses/1/edit
  def edit
  end

  # POST /tipoestatuses
  # POST /tipoestatuses.json
  def create
    @tipoestatus = Tipoestatus.new(tipoestatus_params)

    respond_to do |format|
      if @tipoestatus.save
        format.html { redirect_to @tipoestatus, notice: 'Tipoestatus was successfully created.' }
        format.json { render :show, status: :created, location: @tipoestatus }
      else
        format.html { render :new }
        format.json { render json: @tipoestatus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipoestatuses/1
  # PATCH/PUT /tipoestatuses/1.json
  def update
    respond_to do |format|
      if @tipoestatus.update(tipoestatus_params)
        format.html { redirect_to @tipoestatus, notice: 'Tipoestatus was successfully updated.' }
        format.json { render :show, status: :ok, location: @tipoestatus }
      else
        format.html { render :edit }
        format.json { render json: @tipoestatus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipoestatuses/1
  # DELETE /tipoestatuses/1.json
  def destroy
    @tipoestatus.destroy
    respond_to do |format|
      format.html { redirect_to tipoestatuses_url, notice: 'Tipoestatus was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipoestatus
      @tipoestatus = Tipoestatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipoestatus_params
      params.require(:tipoestatus).permit(:id, :informeId)
    end
end
