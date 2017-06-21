class PermisologiaController < ApplicationController
  before_action :set_permisologium, only: [:show, :edit, :update, :destroy]

  # GET /permisologia
  # GET /permisologia.json
  def index
    @permisologia = Permisologium.all
  end

  # GET /permisologia/1
  # GET /permisologia/1.json
  def show
  end

  # GET /permisologia/new
  def new
    @permisologium = Permisologium.new
  end

  # GET /permisologia/1/edit
  def edit
  end

  # POST /permisologia
  # POST /permisologia.json
  def create
    @permisologium = Permisologium.new(permisologium_params)

    respond_to do |format|
      if @permisologium.save
        format.html { redirect_to @permisologium, notice: 'Permisologium was successfully created.' }
        format.json { render :show, status: :created, location: @permisologium }
      else
        format.html { render :new }
        format.json { render json: @permisologium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /permisologia/1
  # PATCH/PUT /permisologia/1.json
  def update
    respond_to do |format|
      if @permisologium.update(permisologium_params)
        format.html { redirect_to @permisologium, notice: 'Permisologium was successfully updated.' }
        format.json { render :show, status: :ok, location: @permisologium }
      else
        format.html { render :edit }
        format.json { render json: @permisologium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permisologia/1
  # DELETE /permisologia/1.json
  def destroy
    @permisologium.destroy
    respond_to do |format|
      format.html { redirect_to permisologia_url, notice: 'Permisologium was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_permisologium
      @permisologium = Permisologium.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def permisologium_params
      params.require(:permisologium).permit(:id, :permisosId, :usuarioId, :attribute, :read, :write)
    end
end
