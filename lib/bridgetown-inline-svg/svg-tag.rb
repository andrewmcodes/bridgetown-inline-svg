module BridgetownInlineSvg
  class SvgTag < Bridgetown::Builder
    attr_accessor :attributes
    attr_accessor :context

    def build
      liquid_tag "svg", :render
    end

    def render(markup, builder)
      @context = builder.context
      markup = Liquid::Template.parse(markup).render(@context)

      @svg_path, @attributes = BridgetownInlineSvg::Attributes.parse(markup)
      @svg_path = Bridgetown.sanitized_path(site.source, @svg_path)

      return unless @svg_path

      render_svg
    end

    def render_svg
      file = File.open(@svg_path, File::RDONLY).read
      
      xml = Nokogiri::XML(file)
      @attributes.each { |key, value| xml.root.set_attribute(key, value) }
      xml.root.to_xml
    end

    def options
      @options ||= config["svg"] || {}
    end
  end
end

BridgetownInlineSvg::SvgTag.register
