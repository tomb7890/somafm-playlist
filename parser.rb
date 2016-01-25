# Parser class is used to glean a set of links from a program's direct
# links page.
class Parser
  attr_accessor :formats
  def initialize
    @formats = []
  end

  # The # Format class encapsulates a particular format or codec of a
  # program as well as a list of servers (links) to access that
  # format.
  class Format
    attr_accessor :title, :servers
    def initialize
      @title = ''
      @servers = []
    end
  end

  def parse
    modified = create_element_subset
    elem = modified.pop
    f = nil
    until modified.empty?
      f = process_element(elem, f)
      elem = modified.pop
    end
    @formats << f
  end

  def parse_0
    elements = create_element_subset
    fmt = Format.new
    elem = elements.shift
    until elements.empty?
      fmt = process_el(elem, fmt)
      elem = elements.shift
    end
    @formats << fmt
  end

  def print_children(children)
    children.each { |c| puts c.to_s }
  end

  def create_element_subset
    children = create_element_set_from_html
    modified = []
    children.each do |x|
      modified << x if x.name == 'h2' && x.text.include?('kb')
      modified << x if x.name == 'p' && x.attr('class') == 'url'
    end
    # print_children(modified)
    modified.reverse
  end

  def create_element_set_from_html
    html = File.open('dsl.html', 'rb').read
    nokogiri_object = Nokogiri::HTML(html)
    tagcloud_elements = nokogiri_object.xpath("//div[@id='midcontent']")
    tagcloud_elements.children
  end

  def process_element(el, f)
    if el.name == 'h2'
      f = handle_h2(el, f)
    elsif el.name == 'p'
      f = handle_p(el, f)
    end
    f
  end

  def process_el(el, f)
    if el.name == 'h2'
      f = h_h2(el, f)
    elsif el.name == 'p'
      f = h_p(el, f)
    end
    f
  end

  def handle_h2(el, f)
    if f
      @formats << f
    else
      f = Format.new
      f.title = el.text
    end
    f
  end

  def handle_p(el, f)
    f.servers << el.text
    f
  end
end
