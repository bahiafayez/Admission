# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
  $('#applicant_gender').change ->
    #console.log("in here")
    console.log $(this).val()
    if $(this).val()=="Female"
      console.log("in Female")
      $('#applicant_military_status').val("Does not apply").attr("selected", "selected")
      #$("#elementid").val("Oranges").attr("selected", "selected")
      $('#applicant_military_status').attr("disabled","disabled")
    else
      console.log("in male")
      $('#applicant_military_status').removeAttr('disabled')
    
  
  
