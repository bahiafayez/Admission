module ActiveAdminCanCan
  def active_admin_collection
    super.accessible_by current_ability
  end

  def resource
    resource = super
    authorize! permission, resource
    resource
  end

  private

  def permission
    case action_name
    when "show"
      :read
    when "new", "create"
      :create
    when "edit"
      :update
    else
      action_name.to_sym
    end
  end
end


module ActiveAdmin
  class FilterFormBuilder < FormBuilder
    def filter(method, options = {})
      return "" if method.nil? || method == ""
      if options[:if].is_a?(Proc)
        return "" if !template.instance_eval(&options[:if])
      end
      options[:as] ||= default_input_type(method)
      return "" unless options[:as]
      content = input(method, options)
      form_buffers.last << content.html_safe if content
    end
  end
end