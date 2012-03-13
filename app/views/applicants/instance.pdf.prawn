prawn_document(:filename=>'application.pdf') do |pdf|
  
  pdf.text @applicant.first_name
end