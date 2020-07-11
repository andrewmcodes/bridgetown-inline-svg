# frozen_string_literal: true

require_relative "lib/bridgetown-inline-svg/version"

Gem::Specification.new do |spec|
  spec.name = "bridgetown-inline-svg"
  spec.version = BridgetownInlineSvg::VERSION
  spec.authors = ["Andrew Mason"]
  spec.email = ["andrewmcodes@protonmail.com"]

  spec.summary = "A SVG Inliner for Bridgetown"
  spec.description = <<-EOF
  A Liquid tag to inline and optimize SVG images in your HTML
  Supports custom DOM Attributes parameters and variables interpretation.
  EOF
  spec.homepage = "https://github.com/andrewmcodes/bridgetown-inline-svg"
  spec.license = "GPL-3.0"

  spec.metadata = {
    "bug_tracker_uri" => "#{spec.homepage}/issues",
    "changelog_uri" => "#{spec.homepage}/blob/main/CHANGELOG.md",
    "documentation_uri" => spec.homepage.to_s,
    "homepage_uri" => spec.homepage.to_s,
    "source_code_uri" => spec.homepage.to_s
  }

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|script|spec|features|frontend)/}) }
  spec.test_files = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.5.0"

  spec.add_dependency "bridgetown", ">= 0.15", "< 2.0"
  spec.add_dependency "svg_optimizer", "~> 0.2.5"

  spec.add_development_dependency "nokogiri", "~> 1.6"
end
