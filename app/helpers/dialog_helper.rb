module DialogHelper
  def dialog(title, *args, &block)
    options = args.extract_options!
    
    id_attr = options[:id] ? " id=\"#{options[:id]}\"" : ''
    close_part =
      if options[:hide_close]
        ''
      else
        '<span class="close"></span>'
      end
    
    raw <<-HTML
    <div class="dialog_block hidden"#{id_attr}>
      <div class="dialog_header">
        #{close_part}
        <div class="dialog_title">#{title}</div>
      </div>
      
      <div class="dialog_content">
        <div class="dialog_form">
          #{capture(&block)}
        </div>
      </div>
    </div>
    HTML
  end
end
