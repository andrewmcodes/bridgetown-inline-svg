# frozen_string_literal: true

require "bridgetown"

module BridgetownInlineSvg
  autoload :SvgTag, "bridgetown-inline-svg/svg-tag"
end

Liquid::Template.register_tag("svg", BridgetownInlineSvg::SvgTag)
