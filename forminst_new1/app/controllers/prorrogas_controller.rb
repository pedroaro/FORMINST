class ProrrogasController < ApplicationController
  before_action :set_prorroga, only: [:show, :edit, :update, :destroy]

  # GET /prorrogas
  # GET /prorrogas.json
  def index
    @prorrogas = Prorroga.all
  end

  # GET /prorrogas/1
  # GET /prorrogas/1.json
  def show
  end

  # GET /prorrogas/new
  def new
    @prorroga = Prorroga.new
  end

  # GET /prorrogas/1/edit
  def edit
  end

  # POST /prorrogas
  # POST /prorrogas.json
  def create
    @prorroga = Prorroga.new(prorroga_params)

    respond_to do |format|
      if @prorroga.save
        format.html { redirect_to @prorroga, notice: 'Prorroga was successfully created.' }
        format.json { render :show, status: :created, location: @prorroga }
      else
        format.html { render :new }
        format.json { render json: @prorroga.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prorrogas/1
  # PATCH/PUT /prorrogas/1.json
  def update
    respond_to do |format|
      if @prorroga.update(prorroga_params)
        format.html { redirect_to @prorroga, notice: 'Prorroga was successfully updated.' }
        format.json { render :show, status: :ok, location: @prorroga }
      else
        format.html { render :edit }
        format.json { render json: @prorroga.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prorrogas/1
  # DELETE /prorrogas/1.json
  def destroy
    @prorroga.destroy
    respond_to do |format|
      format.html { redirect_to prorrogas_url, notice: 'Prorroga was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prorroga
      @prorroga = Prorroga.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prorroga_params
      params.require(:prorroga).permit(:id, :planFormacionId)
    end
end
