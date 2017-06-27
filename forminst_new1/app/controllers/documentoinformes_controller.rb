class DocumentoinformesController < ApplicationController
  before_action :set_documentoinforme, only: [:show, :edit, :update, :destroy]

  # GET /documentoinformes
  # GET /documentoinformes.json
  def index
    @documentoinformes = Documentoinforme.all
  end

  # GET /documentoinformes/1
  # GET /documentoinformes/1.json
  def show
  end

  # GET /documentoinformes/new
  def new
    @documentoinforme = Documentoinforme.new
  end

  # GET /documentoinformes/1/edit
  def edit
  end

  # POST /documentoinformes
  # POST /documentoinformes.json
  def create
    @documentoinforme = Documentoinforme.new(documentoinforme_params)

    respond_to do |format|
      if @documentoinforme.save
        format.html { redirect_to @documentoinforme, notice: 'Documentoinforme was successfully created.' }
        format.json { render :show, status: :created, location: @documentoinforme }
      else
        format.html { render :new }
        format.json { render json: @documentoinforme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documentoinformes/1
  # PATCH/PUT /documentoinformes/1.json
  def update
    respond_to do |format|
      if @documentoinforme.update(documentoinforme_params)
        format.html { redirect_to @documentoinforme, notice: 'Documentoinforme was successfully updated.' }
        format.json { render :show, status: :ok, location: @documentoinforme }
      else
        format.html { render :edit }
        format.json { render json: @documentoinforme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documentoinformes/1
  # DELETE /documentoinformes/1.json
  def destroy
    @documentoinforme.destroy
    respond_to do |format|
      format.html { redirect_to documentoinformes_url, notice: 'Documentoinforme was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_documentoinforme
      @documentoinforme = Documentoinforme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def documentoinforme_params
      params.require(:documentoinforme).permit(:id, :informeId, :archivo)
    end
end
