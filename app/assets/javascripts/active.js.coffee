$(document).ready ->
  console.log "hrtrrrr"
  $("#semester_sel").change(changeSemester).trigger('change')
  
 
changeSemester = ->
  url = undefined
  url = "/applicants/get_semester?sem=" + $(this).val()
  $.getJSON url, (data) ->
    console.log data
    $('#all_apps').html(data['all'])
    $('#saved_apps').html(data['saved'])
    $('#submitted_apps').html(data['submitted'])
    $('#approved_apps').html(data['approved'])
    $('#rejected_apps').html(data['rejected'])
    $('#closed_apps').html(data['closed'])
    #console.debug 'here'
    #console.debug data['all']
    #for key of data
      # console.log key + " => " + data[key]
    #$("#applicant_admission_information_attributes_major_id").addOption data, false
    