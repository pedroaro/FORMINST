class DocumentoplansController < ApplicationController
  before_action :set_documentoplan, only: [:show, :edit, :update, :destroy]

  # GET /documentoplans
  # GET /documentoplans.json
  def index
    @documentoplans = Documentoplan.all
  end

  # GET /documentoplans/1
  # GET /documentoplans/1.json
  def show
  end

  # GET /documentoplans/new
  def new
    @documentoplan = Documentoplan.new
  end

  # GET /documentoplans/1/edit
  def edit
  end

  # POST /documentoplans
  # POST /documentoplans.json
  def create
    @documentoplan = Documentoplan.new(documentoplan_params)

    respond_to do |format|
      if @documentoplan.save
        format.html { redirect_to @documentoplan, notice: 'Documentoplan was successfully created.' }
        format.json { render :show, status: :created, location: @documentoplan }
      else
        format.html { render :new }
        format.json { render json: @documentoplan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documentoplans/1
  # PATCH/PUT /documentoplans/1.json
  def update
    respond_to do |format|
      if @documentoplan.update(documentoplan_params)
        format.html { redirect_to @documentoplan, notice: 'Documentoplan was successfully updated.' }
        format.json { render :show, status: :ok, location: @documentoplan }
      else
        format.html { render :edit }
        format.json { render json: @documentoplan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documentoplans/1
  # DELETE /documentoplans/1.json
  def destroy
    @documentoplan.destroy
    respond_to do |format|
      format.html { redirect_to documentoplans_url, notice: 'Documentoplan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_documentoplan
      @documentoplan = Documentoplan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def documentoplan_params
      params.require(:documentoplan).permit(:id, :planFormacionId, :archivo)
    end
end
