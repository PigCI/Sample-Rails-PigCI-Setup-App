namespace :test do
  task :pig_ci => :environment do
    ENV['RAILS_ENV'] = 'test'

    # Precomile assets so our first application request doesn't compile them.
    Rake::Task['assets:precompile'].execute

    require 'pig_ci'
    PigCI.start do |config|
      # When you connect your project to pigci.com, you'll be given an API key.
      # This allows you to fail PRs which exceed a preset threshold.
      # If no API key is present, PigCI will run but not be able to pass/fail PRs on GitHub.
      config.api_key = ENV['PIG_CI_KEY']

      # MiniTest doesn't allow for precompiling at this point.
      #config.during_setup_make_blank_application_request = false
      config.during_setup_precompile_assets = false
    end

    Rake::Task['test'].execute
    Rake::Task['test:system'].execute
  end
end
