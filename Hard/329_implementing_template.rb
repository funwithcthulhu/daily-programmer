class HtmlEngine
  def initialize(indent = false)
    @indent = indent
    @indent_level = 0
  end

  def method_missing(method, *args, &block)
    attributes = args[0] || {}
    doc = ''
    doc << ('  ' * @indent_level) if @indent
    doc << "<#{method}"
    attributes.each_pair do |key, value|
      doc << " #{key}='#{value}'"
    end
    if block
      doc << '>'
      doc << "\n" if @indent
      @indent_level += 1
      doc << yield 
      @indent_level -= 1
      doc << ('  ' * @indent_level) if @indent
      doc << "</#{method}>"
      doc << "\n" if @indent
    else
      doc << '/>'
      doc << "\n" if @indent
    end
    doc
  end
end


html = HtmlEngine.new
html_indent = HtmlEngine.new(true)

  
DATA = {
        "store_name": "Barry's Farmer's Market",
        "foods": {
                  "apple": "5.91",
                  "peach": "1.84",
                  "carrot": "6.44",
                  "beans": "3.05",
                  "orange": "5.75",
                  "cucumber": "6.42"
                  },
        "store_location": "Corner of Elm Tree Hill and 158th Street"
        }.freeze

html_indent.head do
  html.title do
    "Local Farmer's Market: #{DATA[:"store_name"]}"
  end
end
html.body do
  html.table do
    erb.th {'Food'}
    erb.th {'Price (10 lbs)'}
    erb.thead
    erb.tbody do
      erb.data do 
        DATA[:"foods"].each do |k, v|
          "#{k}: #{v}\n"
        end
      end
    end
  end
end

