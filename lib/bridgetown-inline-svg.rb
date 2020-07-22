# frozen_string_literal: true

require "bridgetown"
require "bridgetown-inline-svg/tag"

module BridgetownInlineSvg
  autoload :Markup, "bridgetown-inline-svg/markup"
  autoload :RenderSvg, "bridgetown-inline-svg/render_svg"
  autoload :RenderSvgOptimized, "bridgetown-inline-svg/render_svg_optimized"
end
