require 'redmine'
require 'timelog_helper_patch'

Redmine::Plugin.register :redmine_timelog_projects_breadcrumb do
  name 'Redmine Timelog Projects Breadcrumb plugin'
  author 'Jean-Marie Vallet'
  description 'Redmine plugin used to add project breadcrumb in timelog report'
  version '0.0.1'
  requires_redmine :version => ['1.0.5']
  url 'https://github.com/jmvallet/redmine_timelog_projects_breadcrumb'
  author_url 'http://jmvallet.net/'
end
