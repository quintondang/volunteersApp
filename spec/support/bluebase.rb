module BluebaseTestHelpers
  APP_NAME = "dummy"

  def remove_project_directory
    FileUtils.rm_rf(project_path)
  end

  def create_tmp_directory
    FileUtils.mkdir_p(tmp_path)
  end

  def run_bluebase(arguments = nil)
    Dir.chdir(tmp_path) do
      Bundler.with_clean_env do
        ENV["TESTING"] = "1"

        %x(#{bluebase_bin} #{APP_NAME} #{arguments})
      end
    end
  end

  def drop_dummy_database
    if File.exist?(project_path)
      Dir.chdir(project_path) do
        Bundler.with_clean_env do
          `rake db:drop`
        end
      end
    end
  end

  def project_path
    @project_path ||= Pathname.new("#{tmp_path}/#{APP_NAME}")
  end

  private

  def tmp_path
    @tmp_path ||= Pathname.new("#{root_path}/tmp")
  end

  def bluebase_bin
    File.join(root_path, "bin", "bluebase")
  end

  def root_path
    File.expand_path("../../../", __FILE__)
  end
end
