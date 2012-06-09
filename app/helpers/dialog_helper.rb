module DialogHelper
  def dialog(title, *args, &block)
    options = args.extract_options!
    id_attr = options[:id] ? " id=\"#{options[:id]}\"" : ''
    raw <<-HTML
    <div class="dialog_block hidden"#{id_attr}>
      <div class="dialog_header">
        <span class="close"></span>
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
