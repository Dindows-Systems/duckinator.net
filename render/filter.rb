require 'liquid'
require 'redcarpet'

module TextFilter
  def markdown(input)
    parser = Redcarpet.new(input, :smart,
                                  :hard_wrap,
                                  :tables,
                                  :fenced_code,
                                  :strikethrough,
                                  :lax_htmlblock,
                                  :no_intraemphasis)
    parser.to_html
  end

  def date(input)
    Time.now.strftime(input)
  end
end