ActionController::Base.asset_host = Proc.new { |source, request|
  request.env["Rack-Middleware-PDFKit"] == "true"
  # if request.env["REQUEST_PATH"].include? ".pdf"
    # "file://#{Rails.root.join('public')}"
  # else
    # "#{request.protocol}#{request.host_with_port}"
  # end
}