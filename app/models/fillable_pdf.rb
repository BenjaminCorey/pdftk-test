class FillablePdf
  include ActiveModel::Model

  attr_writer :template_path
  attr_accessor :attributes

  def export(output_file_path=nil)
    output_path = output_file_path || "#{Rails.root}/tmp/pdfs/#{SecureRandom.uuid}.pdf" # make sure tmp/pdfs exists
    pdftk.fill_form template_path, output_path, attributes, flatten: true
    output_path
  end

  def get_field_names
    pdftk.get_field_names template_path
  end

  def template_path
    @template_path ||= "#{Rails.root}/lib/pdf_templates/#{self.class.name.gsub('Pdf', '').underscore}.pdf" # makes assumption about template file path unless otherwise specified
  end

  protected

  def attributes
    @attributes ||= {}
  end

  def fill(key, value)
    attributes[key.to_s] = value
  end

  def pdftk
    @pdftk ||= PdfForms.new(ENV['PDFTK_PATH'] || '/usr/local/bin/pdftk') # On my Mac, the location of pdftk was different than on my linux server.
  end
end
