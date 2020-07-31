require "nokogiri"

module BridgetownInlineSvg
  class RenderSvg
    attr_reader :attributes

    def initialize(file_path, attributes)
      @file_path = file_path
      @attributes = attributes
    end

    def call
      xml = Nokogiri::XML(file)
      attributes.each { |key, value| xml.root.set_attribute(key, value) }
      xml.root.to_xml
    end

    private

    def file
      @file ||= File.open(@file_path, File::RDONLY).read
    end
  end
end
