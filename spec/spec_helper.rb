require 'bundler/setup'
require 'capybara/rspec'
require 'pry'

Bundler.require(:default, :test)

require (Pathname.new(__FILE__).dirname + '../lib/bluebase').expand_path

Dir['./spec/support/**/*.rb'].each { |file| require file }
RSpec.configure do |config|
  config.include BluebaseTestHelpers

  config.before(:all) do
    create_tmp_directory
  end

  config.before(:each) do
    drop_dummy_database
    remove_project_directory

    FakeHeroku.clear!
    FakeGithub.clear!
  end
end
