# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
(($) ->
  $.fn.allBut = (context) ->
    target = this
    otherList = $()
    processList = $(context or "body").children()
    while processList.size() > 0
      cElem = processList.first()
      processList = processList.slice(1)
      unless cElem.filter(target).size() is target.size()
        if cElem.has(target).size() > 0
          processList = processList.add(cElem.children())
        else
          otherList = otherList.add(cElem)
    otherList
) jQuery

$(document).ready ->
  $('#applicantform').allBut('#allforms').fadeOut();
  $('#applicantform').show()
  $('.relation3').hide()
  $('#printAd').hide()
  $('#NuSeminar').hide()
  $('#other').hide()
  $('#fieldsofstudy').hide()
  $('#other2').hide()
  

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
      
  $('#applicant_addresses_attributes_0_address_type').change ->
    #console.log("in here")
    console.log $(this).val()
    if $(this).val()=="Both"
      console.log("in Both")
      $(this).parent().parent().parent().children('div').eq(1).hide()
    else
      $(this).parent().parent().parent().children('div').eq(1).show()
      
  $('#applicant_addresses_attributes_1_address_type').change ->
    #console.log("in here")
    console.log $(this).val()
    if $(this).val()=="Both"
      console.log("in Both")
      $(this).parent().parent().parent().children('div').eq(0).hide()
    else
      $(this).parent().parent().parent().children('div').eq(0).show()
      
  
      
  $('.relation').each ->
    $(this).change ->
      console.log "relation was clicked"
      if $(this).val()=="Other"
        console.log "otherrr"
        console.log $(this).parent().parent().children()
        $(this).parent().parent().children('.relation3').show()
      else
        $(this).parent().parent().children('.relation3').hide()
        
  $('#applicantbutton').click ->
    console.log "I was Clicked"
    #$('#applicantform').show()
    #$('#addressform').hide()
    $('#applicantform').allBut('#allforms').fadeOut();
    $('#applicantform').show()
    
  $('#addressbutton').click ->
    console.log "I was Clicked"
    #$('#applicantform').show()
    #$('#addressform').hide()
    $('#addressform').allBut('#allforms').fadeOut();
    $('#addressform').show()
    
  $('#admissioninformationbutton').click ->
    console.log "I was Clicked"
    #$('#applicantform').show()
    #$('#addressform').hide()
    $('#admissionform').allBut('#allforms').fadeOut();
    $('#admissionform').show()
    
  $('#workbutton').click ->
    console.log "I was Clicked"
    #$('#applicantform').show()
    #$('#addressform').hide()
    $('#workform').allBut('#allforms').fadeOut();
    $('#workform').show()

  $('#secondaryschoolbutton').click ->
    console.log "I was Clicked"
    #$('#applicantform').show()
    #$('#addressform').hide()
    $('#secondaryform').allBut('#allforms').fadeOut();
    $('#secondaryform').show()

  $('#collegebutton').click ->
    console.log "I was Clicked"
    #$('#applicantform').show()
    #$('#addressform').hide()
    $('#collegeform').allBut('#allforms').fadeOut();
    $('#collegeform').show()        
    
  $('#unirelatedinfobutton').click ->
    console.log "I was Clicked"
    #$('#applicantform').show()
    #$('#addressform').hide()
    $('#uniform').allBut('#allforms').fadeOut();
    $('#uniform').show()
    
  $('#healthbutton').click ->
    console.log "I was Clicked"
    #$('#applicantform').show()
    #$('#addressform').hide()
    $('#healthform').allBut('#allforms').fadeOut();
    $('#healthform').show()

  $('#attachmentbutton').click ->
    console.log "I was Clicked"
    #$('#applicantform').show()
    #$('#addressform').hide()
    $('#attachmentform').allBut('#allforms').fadeOut();
    $('#attachmentform').show()

  $('#guardianbutton').click ->
    console.log "I was Clicked"
    #$('#applicantform').show()
    #$('#addressform').hide()
    $('#guardianform').allBut('#allforms').fadeOut();
    $('#guardianform').show()  
    
  $('#applicant_reasons_PrintAd').click ->
    console.log "wohoo"
    if $(this).is(':checked')
      console.log "over here"
      $('#printAd').show()
    else  
      $('#printAd').hide()
      
  $('#applicant_reasons_NUSeminar').click ->
    console.log "wohoo"
    if $(this).is(':checked')
      console.log "over here"
      $('#NuSeminar').show()
    else  
      $('#NuSeminar').hide()
      
  $('#applicant_reasons_Other').click ->
    console.log "wohoo"
    if $(this).is(':checked')
      console.log "over here"
      $('#other').show()
    else  
      $('#other').hide()
      
  $('#applicant_reasons2_fieldsOfStudy').click ->
    console.log "wohoo"
    if $(this).is(':checked')
      console.log "over here"
      $('#fieldsofstudy').show()
    else  
      $('#fieldsofstudy').hide()
      
  $('#applicant_reasons2_Other').click ->
    console.log "wohoo"
    if $(this).is(':checked')
      console.log "over here"
      $('#other2').show()
    else  
      $('#other2').hide()
      
  $('#applicant_checkSecondary_oneSchool').click ->
    console.log "wohoo"
    if $(this).is(':checked')
      console.log "over here"
      $('#applicant_checkSecondary_oneSchool').parent().parent().children('div').eq(1).hide()
    else  
      $('#applicant_checkSecondary_oneSchool').parent().parent().children('div').eq(1).show()
      
  $('#applicant_checkCollege_oneCollege').click ->
    console.log "wohoo"
    if $(this).is(':checked')
      console.log "over here"
      $('#applicant_checkCollege_oneCollege').parent().parent().children('div').eq(1).hide()
    else  
      $('#applicant_checkCollege_oneCollege').parent().parent().children('div').eq(1).show()
      
  $('#applicant_checkWork_oneWork').click ->
    console.log "wohoo"
    if $(this).is(':checked')
      console.log "over here"
      $('#applicant_checkWork_oneWork').parent().parent().children('div').eq(1).hide()
    else  
      $('#applicant_checkWork_oneWork').parent().parent().children('div').eq(1).show()
      
