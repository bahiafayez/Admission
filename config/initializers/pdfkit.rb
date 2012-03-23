# config/initializers/pdfkit.rb  
  
  
#PDFKit.configure do |config|          
#     config.wkhtmltopdf = Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s if Rails.env.production?     
#end  
PDFKit.configure do |config|
    config.wkhtmltopdf = 'C:/Program Files/wkhtmltopdf/wkhtmltopdf.exe'
  end
WICKED_PDF = {
:exe_path => '/bin'
}