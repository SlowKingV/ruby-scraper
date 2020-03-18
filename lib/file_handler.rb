class FileHandler
  @current = nil
  @repo_dir = Dir.open('repo/')
  attr_reader :file, :file_path

  def initialize(filename, dir = self.class.repo_dir)
    @repo_dir = dir
    @file_path = @repo_dir.path + filename + '.xml'
    access = File.exist?(@file_path) ? 'r+' : 'w+'
    load_file(access)
  end

  def load_file(access)
    @file = File.new(@file_path, access)
  end

  def read
    File.read(@file_path)
  end

  class << self
    attr_reader :repo_dir

    def list_files
      @repo_dir.entries.select { |entry| entry =~ /\.xml$/ }
    end

    def delete_file(path)
      File.delete(path) if File.exist?(path)
    end
  end
end
