require 'erb'

module Raincoat
  class Script
    def initialize(name, value)
      @name = name
      @value = value
    end

    def to_s
      ERB.new(TEMPLATE).result(binding)
    end

    private

    def class_name_for(file_name)
      file_name.split(/_/).map{ |s| s.capitalize }.join('')
    end

    TEMPLATE = <<ERB_TEMPLATE
class <%= class_name_for(@name) %>
  def call(diff)
    <%= @value %>
  end
end
ERB_TEMPLATE
  end
end
