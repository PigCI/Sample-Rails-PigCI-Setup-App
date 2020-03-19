namespace :test do
  task :pig_ci => :environment do
    ENV['RAILS_ENV'] = 'test'

    # Precomile assets so our first application request doesn't compile them.
    Rake::Task['assets:precompile'].execute

    # Pig CI doesn't support Minitest yet - I'm working on it.

    Rake::Task['test'].execute
    Rake::Task['test:system'].execute
  end
end
