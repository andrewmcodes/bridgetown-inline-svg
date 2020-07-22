# Converts the attributes passed to the tag into a path & hash.
module BridgetownInlineSvg
  class Attributes
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
    end

    private

    
  end
end
