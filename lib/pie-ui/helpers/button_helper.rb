module ButtonHelper
  def minibutton_remote(name, options = {}, html_options = {}, &block)
    link_to_remote("<span>#{name}</span>",options,html_options.merge({:class=>'minibutton'}),&block)
  end
end
