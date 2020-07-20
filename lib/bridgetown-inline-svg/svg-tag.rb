module BridgetownInlineSvg
  class SvgTag < Bridgetown::Builder
    include Bridgetown::LiquidExtensions

    attr_accessor :attributes
    attr_accessor :context

    def build
      liquid_tag "svg", :render
    end

    def render(markup, builder)
      @context = builder.context

      #markup = interpolate_markup(markup, builder)
      puts markup.inspect
      set_attributes!(markup)

      svg_path = File.join site.source, attributes[0].gsub("../", "")
      svg_lines = File.readlines(svg_path).map(&:strip).select do |line|
        line unless line.start_with?("<!", "<?xml")
      end
      svg_lines.join
    end

    # Find any variables that haven't been interpolated within our markup
    # and processing them first.
    def interpolate_markup(markup, builder)
      markup.scan Liquid::PartialTemplateParser do |variable|
        markup = markup.sub(Liquid::PartialTemplateParser, lookup_variable(context, variable.first))
      end
      markup
    end

    def set_attributes!(markup)
      @attributes = {}
      markup.scan(Liquid::TagAttributes) do |key, value|
        @attributes[key] = Liquid::Expression.parse(value)
      end

      # IE11 requires we have both width & height attributes
      # on SVG elements
      if @attributes.key?("width") && !@attributes.key?("height")
        @attributes["height"] = @attributes["width"]
      end
    end

    def options
      @options ||= config["svg"] || {}
    end
  end
end

BridgetownInlineSvg::SvgTag.register
