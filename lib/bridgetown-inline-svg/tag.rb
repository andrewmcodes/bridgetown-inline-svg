module BridgetownInlineSvg
  class Tag < Bridgetown::Builder
    attr_reader :attributes
    attr_reader :context
    attr_reader :markup
    attr_reader :svg_path

    def build
      liquid_tag "svg", :render
    end

    def render(markup, builder)
      @context = builder.context
      @markup = markup

      interpolate_variables_in_markup!
      set_svg_path_and_attributes!

      return unless svg_path

      add_file_to_dependency!

      render_svg
    end

    private

    # Parse any variables in our Markup
    def interpolate_variables_in_markup!
      @markup = Liquid::Template.parse(markup).render(context)
    end

    def set_svg_path_and_attributes!
      @svg_path, @attributes = Markup.parse(markup)
      @svg_path = Bridgetown.sanitized_path(site.source, svg_path)
    end

    # When we change the svg, it'll regenerate our page.
    def add_file_to_dependency!
      if context.registers[:page]&.key?("path")
        site.regenerator.add_dependency(
          site.in_source_dir(context.registers[:page]["path"]),
          svg_path
        )
      end
    end

    def render_svg
      render_svg_class.new(svg_path, attributes).call
    end

    def render_svg_class
      options["optimize"] == true ? RenderOptimizedSvg : RenderSvg
    end

    def options
      config["svg"] || {}
    end
  end
end

BridgetownInlineSvg::Tag.register
