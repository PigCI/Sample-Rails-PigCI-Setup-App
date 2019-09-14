[![Build Status](https://travis-ci.com/PigCI/Sample-Rails-PigCI-Setup-App.svg?branch=master)](https://travis-ci.com/PigCI/Sample-Rails-PigCI-Setup-App)
[![CircleCI](https://circleci.com/gh/PigCI/Sample-Rails-PigCI-Setup-App/tree/master.svg?style=svg)](https://circleci.com/gh/PigCI/Sample-Rails-PigCI-Setup-App/tree/master)

# Sample Rails [PigCI](https://pigci.com) Setup

![Sample Output of PigCI in TravisCI](https://user-images.githubusercontent.com/325384/64909005-7b4a1280-d6fe-11e9-8a1f-c40d21eeb4a7.png)


This is a sample app for demonstrating how to setup the [pig-ci-rails](https://github.com/PigCI/pig-ci-rails) gem in your Ruby on Rails application, so you can monitor key metrics of your test suite.

Once setup, PigCI will monitor your app during when you run the test suite. Once the tests are complete it will output the key stats to terminal & to the `/pig-ci` folder.

## Getting Setup

### Add the gem

Add the gem to your Gemfile:

```ruby
group :test do
  gem 'pig-ci-rails'
end
```

### Update Gitignore

Ignore the `pig-ci` folder, which is where metrics are saved for review after tests are ran by updating `.gitignore` with:

```text
# PigCI
/pig-ci
```

### Setup for RSpec

Update `spec/rails_helper.rb` with the following:

```ruby
require 'pig_ci'
PigCI.start do |config|
  # When you connect your project to pigci.com, you'll be given an API key.
  # This allows you to fail PRs which exceed a preset threshold.
  # If no API key is present, PigCI will run but not be able to pass/fail PRs on GitHub.
  config.api_key = ENV['PIG_CI_KEY']
end if RSpec.configuration.files_to_run.count > 1
```

I suggest storing the `api_key` value in an environment variable, as it'll allow as you to only pass/fail PRs when data is sent from a specific environment (e.g. Travis-CI, CircleCI or Codeship).

## Configuring Travis-CI

I've setup a sample [.travis.yml](https://github.com/PigCI/Sample-Rails-PigCI-Setup-App/blob/master/.travis.yml) file, once you've added that to you repo you should be add `PIG_CI_KEY` to travis-ci environment settings to send data to pigci.com.

![Travis CI environment configuration](https://user-images.githubusercontent.com/325384/64908904-3ffb1400-d6fd-11e9-9044-041f2f66315f.png)
