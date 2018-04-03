class EstatusinformesController < ApplicationController
  before_action :set_estatusinforme, only: [:show, :edit, :update, :destroy]

  # GET /estatusinformes
  # GET /estatusinformes.json
  def index
    @estatusinformes = Estatusinforme.all
  end

  # GET /estatusinformes/1
  # GET /estatusinformes/1.json
  def show
  end

  # GET /estatusinformes/new
  def new
    @estatusinforme = Estatusinforme.new
  end

  # GET /estatusinformes/1/edit
  def edit
  end

  # POST /estatusinformes
  # POST /estatusinformes.json
  def create
    @estatusinforme = Estatusinforme.new(estatusinforme_params)

    respond_to do |format|
      if @estatusinforme.save
        format.html { redirect_to @estatusinforme, notice: 'Estatusinforme was successfully created.' }
        format.json { render :show, status: :created, location: @estatusinforme }
      else
        format.html { render :new }
        format.json { render json: @estatusinforme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /estatusinformes/1
  # PATCH/PUT /estatusinformes/1.json
  def update
    respond_to do |format|
      if @estatusinforme.update(estatusinforme_params)
        format.html { redirect_to @estatusinforme, notice: 'Estatusinforme was successfully updated.' }
        format.json { render :show, status: :ok, location: @estatusinforme }
      else
        format.html { render :edit }
        format.json { render json: @estatusinforme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /estatusinformes/1
  # DELETE /estatusinformes/1.json
  def destroy
    @estatusinforme.destroy
    respond_to do |format|
      format.html { redirect_to estatusinformes_url, notice: 'Estatusinforme was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_estatusinforme
      @estatusinforme = Estatusinforme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def estatusinforme_params
      params.require(:estatusinforme).permit(:id, :informeId, :fecha, :estatusId, :actual)
    end
end
