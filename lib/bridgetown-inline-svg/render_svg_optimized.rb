require "svg_optimizer"

module BridgetownInlineSvg
  class RenderSvgOptimized < RenderSvg
    PLUGINS_BLOCKLIST = [
      SvgOptimizer::Plugins::CleanupId
    ]

    PLUGINS = SvgOptimizer::DEFAULT_PLUGINS.delete_if { |plugin|
      PLUGINS_BLOCKLIST.include?(plugin)
    }

    def call
      SvgOptimizer.optimize(file, [create_plugin!] + PLUGINS)
    end

    private

    def create_plugin!
      mod = Class.new(SvgOptimizer::Plugins::Base) {
        def self.set(params)
          @@params = params
        end

        def process
          @@params.each { |key, value| xml.root.set_attribute(key, value) }
          xml
        end
      }
      mod.set(@attributes)
      mod
    end
  end
end
