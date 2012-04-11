jQuery ->
  specific_activities = $('#specific_activity_id').html()
  $('#activity_id').change ->
    country = $('#activity_id :selected').text()
    escaped_activity = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(specific_activities).filter("optgroup[label='#{escaped_activity}']").html()
    if options
      $('#specific_activity_id').html(options)
      $('#hide').show()
    else
      $('#specific_activity_id').empty()
	  $('#hide').hide()
