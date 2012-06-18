module ApplicationHelper  
  def mark_required(object, attribute)  
    image_tag('required-star.gif',:class => "required" ) if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator  
  end  
end   