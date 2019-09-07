namespace :test do
  task :pig_ci do
    require 'pig_ci'
    PigCI.start do |config|
      # When you connect your project, you'll be given an API key.
      config.api_key = ENV['PIG_CI_KEY']
      config.during_setup_precompile_assets = false
    end
    Rake::Task['test'].execute
    Rake::Task['test:system'].execute
  end
end
