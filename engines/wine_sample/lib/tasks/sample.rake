require 'ffaker'
require 'pathname'
require 'spree/sample'

namespace :wine_sample do
  desc 'Loads sample data'
  task :load => :environment do
    if ARGV.include?("db:migrate")
      puts %Q{
Please run db:migrate separately from wine_sample:load.

Running db:migrate and wine_sample:load at the same time has been known to
cause problems where columns may be not available during sample data loading.

Migrations have been run. Please run "rake wine_sample:load" by itself now.
      }
      exit(1)
    end

    SpreeSample::Engine.load_samples
  end
end


