[![Build Status](https://travis-ci.com/PigCI/Sample-Rails-PigCI-Setup-App.svg?branch=master)](https://travis-ci.com/PigCI/Sample-Rails-PigCI-Setup-App)
[![CircleCI](https://circleci.com/gh/PigCI/Sample-Rails-PigCI-Setup-App/tree/master.svg?style=svg)](https://circleci.com/gh/PigCI/Sample-Rails-PigCI-Setup-App/tree/master)

# Sample Rails [PigCI](https://pigci.com) Setup

![Sample Output of PigCI in TravisCI](https://user-images.githubusercontent.com/325384/78711087-545b6400-790e-11ea-96b7-bb75c119914a.png)


This is a sample app for demonstrating how to setup the [pig-ci-rails](https://github.com/PigCI/pig-ci-rails) gem in your Ruby on Rails application, so you can monitor key metrics of your test suite.

Once setup, PigCI will monitor your app during when you run the test suite. Once the tests are complete it will output the key stats to terminal & to the `/pig-ci` folder.

## Getting Setup

### With RailsBytes

In terminal, run:

```bash
$ rails app:template LOCATION='https://railsbytes.com/script/Vdrswr'
```

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
  # Setup your thresholds if you don't like the defaults
  # Maximum memory in megabytes
  config.thresholds.memory = 300

  # Maximum time per a HTTP request
  config.thresholds.request_time = 200

  # Maximum database calls per a request
  config.thresholds.database_request = 15
end if RSpec.configuration.files_to_run.count > 1
```
