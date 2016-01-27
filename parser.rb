# Parser class is used to glean a set of links from a program's direct
# links page.
class Parser
  attr_accessor :formats
  def initialize
    @formats = []
  end

  def parse(page)
    elems = midcontent_elements(page)
    f = nil
    elems.each do |el|
      f = heading_x(f, el) if a_heading?(el)
      f = p_x(f, el) if a_p?(el)
    end
    finish_pending_object(f)
  end

  private

  def heading_x(f, el)
    # When a h2 heading element is found, probably it means a new
    # stream type is found
    finish_pending_object(f)
    f = make_new_object(el)
    f
  end

  def p_x(f, el)
    # when a P element is found it likely means another server has
    # been found
    f.servers << el.text
    f
  end

  def make_new_object(elem)
    f = Format.new
    f.title = elem.text
    f
  end

  def finish_pending_object(f)
    return unless f
    return unless f.servers.size > 0
    @formats << f
  end

  def print_children(children)
    children.each { |c| puts c.to_s }
  end

  def printit(el)
    classval = el.attr('class')
    puts "Name: #{el.name}; Value: <#{el.text}>; class: <#{classval}>"
  end

  def a_heading?(x)
    # return true if a heading of special interest
    x.name == 'h2' && x.text.include?('kb')
  end

  def a_p?(x)
    # paragraph text of class url will contain a server URI in its
    # text
    x.name == 'p' && x.attr('class') == 'url'
  end

  def midcontent_elements(page)
    # this method gathers the elements of interest from the middle of
    # the document
    nokogiri_object = Nokogiri::HTML(page)
    elements = nokogiri_object.xpath("//div[@id='midcontent']")
    elements.children
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
end
