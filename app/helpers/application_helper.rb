module ApplicationHelper
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
end

