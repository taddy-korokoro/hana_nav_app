module ApplicationHelper
  # devise関連ページのみ最大の横幅を700pxとして，それ以外は1200px
  def devise_controller_class
    devise_controller? ? 'mw-md' : 'mw-xl'
  end

  def bootstrap_error_messages!
    return "" if @travel_record.errors.empty?

    html = ""
    @travel_record.errors.full_messages.each do |error_message|
      html += <<-EOF
      <div class="alert alert-danger alert-dismissible" role="alert">
        <button type="button" class="close" data-dismiss="alert">
          <span aria-hidden="true">&times;</span>
          <span class="sr-only">close</span>
        </button>
        #{error_message}
      </div>
      EOF
    end
    html.html_safe
  end
end
