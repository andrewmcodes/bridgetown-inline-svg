module BridgetownInlineSvg
  class Tag < Bridgetown::Builder
    attr_accessor :attributes
    attr_accessor :context

    def build
      liquid_tag "svg", :render
    end

    def render(markup, builder)
      @context = builder.context

      # Parse any variables in our Markup
      markup = Liquid::Template.parse(markup).render(@context)

      # Get the path & attributes from that markup
      @svg_path, @attributes = Markup.parse(markup)
      @svg_path = Bridgetown.sanitized_path(site.source, @svg_path)

      return unless @svg_path

      add_file_to_dependency!

      render_svg
    end

    private

    def render_svg
      render_svg_class.new(@svg_path, @attributes).call
    end

    # When we change the svg, it'll regenerate our page.
    def add_file_to_dependency!
      if context.registers[:page]&.key?("path")
        site.regenerator.add_dependency(
          site.in_source_dir(context.registers[:page]["path"]),
          @svg_path
        )
      end
    end

    def render_svg_class
      options["optimize"] == true ? RenderSvgOptimized : RenderSvg
    end

    def options
      config["svg"] || {}
    end
  end
end

BridgetownInlineSvg::Tag.register
