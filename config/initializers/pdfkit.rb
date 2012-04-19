# config/initializers/pdfkit.rb  
  
  
PDFKit.configure do |config|          

  config.wkhtmltopdf = Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s if Rails.env.production?     
end  
  # PDFKit.configure do |config|
      # config.wkhtmltopdf = 'C:/Program Files/wkhtmltopdf/wkhtmltopdf.exe'
    # end

   #config.wkhtmltopdf = Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s #if Rails.env.production?  
   #config.default_options[:ignore_load_errors] = true
   #config.wkhtmltopdf = `which wkhtmltopdf`.to_s.strip
   #config.default_options = {
   # :encoding=>"UTF-8",
   # :page_size=>"A4",
   # :margin_top=>"0.25in",
   # :margin_right=>"1in",
   # :margin_bottom=>"0.25in",
   # :margin_left=>"1in",
   # :disable_smart_shrinking=>false
   # }
#end


#  PDFKit.configure do |config|
#      config.wkhtmltopdf = 'C:/Program Files/wkhtmltopdf/wkhtmltopdf.exe'
#    end

WICKED_PDF = {
:exe_path => '/bin'
}