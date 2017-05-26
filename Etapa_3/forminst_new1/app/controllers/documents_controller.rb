class DocumentsController < ApplicationController
  layout 'ly_inicio_tutor'
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    if session[:usuario_id] && session[:tutor]
      @plan = Planformacion.where(id: session[:plan_id]).take
      @documents = []
      if !session[:informe_id].blank?
        @documents = Document.where(adecuacion_id: session[:adecuacion_id], informe_id: session[:informe_id]).all
      else
        @documents = Document.where(adecuacion_id: session[:adecuacion_id], informe_id: nil).all
      end
    else
      redirect_to controller:"forminst", action: "index"
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    send_data(@document.file_contents,
              type: @document.content_type,
              filename: @document.filename)
  end

  # GET /documents/new
  def new
    @bool_enviado = 0
    @adecuacion = Adecuacion.where(planformacion_id: session[:plan_id]).take
    estatus_adecuacion = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
    if (estatus_adecuacion.estatus_id != 6 && estatus_adecuacion.estatus_id != 5)
      @bool_enviado = 1
    end
    if ( @bool_enviado == 1)
      flash[:info]="No puede añadir soportes, ya ha enviado la adecuación"
    else
      @document = Document.new
    end
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    if session[:usuario_id] && session[:tutor]
      @document = Document.new(document_params)
      @planformacion = Planformacion.find(session[:plan_id])
      @adecuacion = Adecuacion.where(planformacion_id: session[:plan_id]).take
      @document.instructor_id = @planformacion.instructor_id
      @document.tutor_id = session[:usuario_id]
      @document.adecuacion_id = @adecuacion.id
      @document.informe_id = session[:informe_id]
      respond_to do |format|
        if @document.save
          flash[:success]="El documento se ha subido con exito"
          format.html { redirect_to documents_url }
        else
          format.html { render :new }
          format.json { render json: @document.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to controller:"forminst", action: "index"
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      flash[:success]="El documento fue borrado con exito"
      format.html { redirect_to documents_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
     params.require(:document).permit(:file)
    end
end
