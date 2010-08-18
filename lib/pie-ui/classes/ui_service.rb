class UiService < ActiveResource::Base
  PROJECT_CONFIG = YAML.load_file(Rails.root.join("config/project_config.yml"))[RAILS_ENV]
  self.site = PROJECT_CONFIG["ui_url"]

  class << self
    def css_files
      ['common','ui'].map{|x| css_path(x)}
    end

    def css_path(bundle_name)
      "#{self.site}stylesheets/bundle_#{bundle_name}.css?#{randstr}"
    end

    def theme_css_file
      "#{self.site}stylesheets/themes/black.css?#{randstr}"
    end
  end

  class << self
    def js_lib_files
      [
        "#{self.site}javascripts/dev/prototype/protoaculous.1.8.3.min.js?#{randstr}",
        "#{self.site}javascripts/dev/jquery/jquery-1.4.2.min.noconflict.js?#{randstr}"
      ]
    end

    def js_files
      ['common','mindpin'].map{|x| js_path(x)}
    end

    def js_path(bundle_name)
      "#{self.site}javascripts/bundle_#{bundle_name}.js?#{randstr}"
    end
  end
end
