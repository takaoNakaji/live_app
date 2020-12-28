module ApplicationHelper
  require "uri"

  # テキスト内のURLテキストをハイパーリンクにします。
  def text_url_to_link(text)
    URI.extract(text, %w[http https]).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"
      text.gsub!(url, sub_text)
    end
    text
  end

  # ページごとの完全なタイトルを返します。
  def full_title(page_title = '')
    base_title = "Stcheck"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end
