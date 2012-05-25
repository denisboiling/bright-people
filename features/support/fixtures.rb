require 'active_record/fixtures'

Before do
  ActiveRecord::Fixtures.reset_cache
  fixtures_folder = Rails.root.join('spec/fixtures')
  fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
  ActiveRecord::Fixtures.create_fixtures(fixtures_folder, fixtures)
end
