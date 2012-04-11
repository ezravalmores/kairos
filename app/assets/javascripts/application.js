// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require_tree .

function updateActivity(select,action) {
  if(select.selectedIndex > 0){
    select.form.action=action;
    select.form.submit();
  }
}

function add_fields(link, association, content) {
	  var new_id = new Date().getTime();
	  var regexp = new RegExp("new_" + association, "g")
	  $(link).parent().before(content.replace(regexp, new_id));
}

function toggleMaster(checkbox, master) {
  master = $j(master)
  if (!master) return
  if (master.checked && !checkbox.checked) {
    master.checked = false;
  }
}

function toggleItems(master, className) {
  var items = document.getElementsByClassName(className);
  if (master.checked) {
    for (i = 0; i < items.length; i++) { items[i].checked = true; }
  } else {
    for (i = 0; i < items.length; i++) { items[i].checked = false; }
  }
}





