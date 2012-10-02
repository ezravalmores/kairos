module ApplicationHelper
  def flash_notice(message, type)
    # note: you must have a div with id='notices' or rename the div appended to below with your element which
    # is the container for the flash messages
    flash.discard
    notice = <<-EOF
      $("html, body").animate({ scrollTop: 0 }, 1000);
      $('div#for_flash').replaceWith("<div id='for_flash'></div>");
      $('div#for_flash').prepend("<div class='#{type}'><h3>#{message}</h3></div>");
      $('#for_flash').delay(500).slideDown('slow').delay('8000').slideUp('slow'); 
    EOF
    notice.html_safe
  end
  
  def add_activity_link(name)
    link_to_function name, :id => "add-activity-link", :class => "red" do |page|
      page.show 'add-activity-form'
      page.hide 'add-activity-link'
    end
  end
  
  def javascripts(*scripts)
    content_for(:javascripts) do
      javascript_include_tag(scripts)
    end
  end
  
  def button(text,link="#",options={})
    content_tag(:div,link_to(text,link,options),{:class => "add_button"})
  end
  
  def compute_utilization_rate(productive_hours,productive_minutes)
    total_minutes = (productive_hours.to_i * 60) + productive_minutes.to_i
    total_hours = 390
    total = number_with_precision((total_minutes.to_i / 390.00) * 100, :precision => 2)
    total
  end
  
  def trash_can
    image_tag('trash.gif', :class => 'trash')
  end  
  
  def kairos_end_switch
    switch = '<div id="kairos_end_switch"></div>'.html_safe
    switch += hidden_field_tag('end_shift')
    content_tag(:div,switch)
  end
end

