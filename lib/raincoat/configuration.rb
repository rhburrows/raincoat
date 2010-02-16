module Raincoat
  class Configuration
    attr_reader :script_dir

    DEFAULT_CONFIG = {
      'script_dir' => 'script'
    }

    def self.file
      ENV["RAINCOAT_CONFIG"] || "raincoat.yml"
    end

    def initialize
      if File.exists?(Configuration.file)
        config = YAML::load_file(Configuration.file)
      else
        config = DEFAULT_CONFIG
      end
      @script_dir = config['script_dir'] || DEFAULT_CONFIG['script_dir']
    end
  end
end
