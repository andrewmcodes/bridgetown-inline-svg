# Converts the mark passed to the tag into a path & a hash of arguments.
module BridgetownInlineSvg
  class Markup
    attr_reader :markup

    # Separate file path from other attributes
    PATH_SYNTAX = %r{
      ^(?<path>[^\s"']+|"[^"]+"|'[^']+')
      (?<params>.*)
    }x

    # Parse the first parameter in a string, giving :
    #  [full_match, param_name, double_quoted_val, single_quoted_val, unquoted_val]
    # The Regex works like :
    # - first group
    #    - match a group of characters that is alphanumeric, _ or -.
    # - second group (non-capturing OR)
    #    - match a double-quoted string
    #    - match a single-quoted string
    #    - match an unquoted string matching the set : [\w\.\-#]
    #
    PARAM_SYNTAX = %r{
    ([\w-]+)\s*=\s*
      (?:"([^"\\]*(?:\\.[^"\\]*)*)"|'([^'\\]*(?:\\.[^'\\]*)*)'|([\w.\-#]+))
    }x

    def self.parse(markup)
      new(markup).call
    end

    def initialize(markup)
      @markup = markup
    end

    def call
      raise_exception! unless matched

      [path, params]
    end

    private

    def matched
      @matched ||= markup.strip.match(PATH_SYNTAX)
    end

    def path
      @path ||= matched["path"].sub(%r{^["']}, "").sub(%r{["']$}, "").strip
    end

    def params
      @params = {}

      params_parse_with_liquid_match!
      params_parse_with_custom_match!
      params_set_height_if_missing!

      @params
    end

    # Scan for arguments using liquids regex
    # From: https://github.com/Shopify/liquid/blob/57c9cf64ebc777fe5e92d4408d31a911f087eeb4/lib/liquid/tags/render.rb#L27
    def params_parse_with_liquid_match!
      raw_params.scan(Liquid::TagAttributes) do |key, value|
        @params[key.to_sym] = value
      end
    end

    # Scan using our regex to support id="some-id"
    def params_parse_with_custom_match!
      raw_params.scan(PARAM_SYNTAX) do |key, group_2, group_3, group_4|
        @params[key.to_sym] = (group_2 || group_3 || group_4)
      end
    end

    # IE11 requires we have both width & height attributes
    # on SVG elements
    def params_set_height_if_missing!
      if @params.key?(:width) && @params[:width] != "" && !@params.key?(:height)
        @params[:height] = @params[:width]
      end
    end

    def raw_params
      @raw_params = matched["params"].strip
    end

    def raise_exception!
      raise SyntaxError, <<~END
        Syntax Error in tag 'svg' while parsing the following markup:
        #{markup}
        Valid syntax: svg <path> [property=value]
      END
    end
  end
end
