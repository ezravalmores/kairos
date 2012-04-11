$(document).ready(function() {
  var activity_counter = 0;
  var leave_counter = 0;		
   $('#activity_initial').click(function(){
	 if (activity_counter ==0){		
     $('#activity_container').slideDown('slow');
     activity_counter = 1;
     }
     else {
	 $('#activity_container').slideUp('slow');
	 activity_counter =0;
     }
 });
   $('#leave_initial').click(function(){
	 if (leave_counter ==0){		
     $('#leave_container').slideDown('slow');
     leave_counter = 1;
     }
     else {
	 $('#leave_container').slideUp('slow');
	 leave_counter =0;
     }
 });	
});