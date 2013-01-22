module TimelogHelperPatch

  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :format_criteria_value, :project_txt_breadcrumb
    end
  end
  
  module InstanceMethods
    
    def format_criteria_value_with_project_txt_breadcrumb(criteria, value)
      self.format_criteria_value_patch(criteria, value, false)
    end
    
    def format_criteria_value_with_project_link_breadcrumb(criteria, value)
      self.format_criteria_value_patch(criteria, value, true)
    end
    
    def format_criteria_value_patch(criteria, value, enable_link = false)
      if value.blank?
        l(:label_none)
      elsif k = criteria[:klass]
        obj = k.find_by_id(value.to_i)
        
        if obj.is_a?(Issue)
          obj.visible? ? "#{obj.tracker} ##{obj.id}: #{obj.subject}" : "##{obj.id}"
        elsif obj.is_a?(Project)
          b = []
          ancestors = (obj.root? ? [] : obj.ancestors.visible)
          if ancestors.any?
            if enable_link
              b += ancestors.collect {|p| link_to_project(p) }
            else
              b += ancestors.collect {|p| p.name }
            end
          end
          if enable_link
            b << link_to_project(obj)
            return b.join( " &raquo; " ).html_safe
          else
            b << obj.name
            return b.join( " | " ).html_safe.encode('UTF-8', 'ISO-8859-1')
          end
        else
          obj
        end
      else
        format_value(value, criteria[:format])
      end
    end
    
  end
end
