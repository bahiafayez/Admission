// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require rails.validations
//= require bootstrap.min.js
//= require bootstrap-tooltip.js
//= require bootstrap-popover.js
//= require jquery.selectboxes.js
//= require formToWizard.js

// $(function() {
  // return $("#applicant_admission_information_attributes_program_id").change(function() {
    // var url;
    // url = "/applicants/update_major_select?program_id=" + $(this).val();
    // $("#applicant_admission_information_attributes_major_id").removeOption(/./);
    // return $.getJSON(url, function(data) {
      // //console.log(data);
      // for (var key in data) {
		    // console.log(key + ' => ' + data[key]);
		    // // key is key
		    // // value is p[key]
		// }
      // return $("#applicant_admission_information_attributes_major_id").addOption(data, false);
    // });
  // });
// });
         $(document).ready(function(){
            $("#SignupForm").formToWizard({ submitButton: 'SaveAccount' })
        });