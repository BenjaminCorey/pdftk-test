class PdfResponsesController < ApplicationController

  def index
    @pdf_responses = PdfResponse.all
  end

  def show
    @pdf_response = PdfResponse.find params[:id]
    respond_to do |format|
      format.html
      format.pdf do
        pdf = FillablePdf.new template_path: "#{Rails.root}/lib/pdf_templates/binti_form.pdf", attributes: @pdf_response.data
        byebug
        file_name = pdf.export
        send_file file_name, disposition: 'inline'
      end
    end
  end

  def new
    @pdf_response = PdfResponse.new
  end

  def create
    @pdf_response = PdfResponse.new pdf_response_params
    if @pdf_response.save
      redirect_to @pdf_response
    else
      render 'new'
    end
  end

  private
  def pdf_response_params
    params.require(:pdf_response).permit(data: [:first_name, :last_name, :description, :gender])
  end
end
