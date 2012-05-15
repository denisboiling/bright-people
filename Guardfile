group 'rspec' do
  guard 'spork', :rspec_env => { 'RAILS_ENV' => 'test' },
  :rspec => true,
  :cucumber => false,
  :test_unit => false,
  :aggressive_kill => true do
    watch('config/application.rb')
    watch('config/environment.rb')
    watch(%r{^extras/.+\.rb$})
    watch(%r{^config/environments/.+\.rb$})
    watch(%r{^config/initializers/.+\.rb$})
    watch('Gemfile')
    watch('Gemfile.lock')
    watch('spec/spec_helper.rb') { :rspec }
    watch('spec/support/**/*.rb') { :rspec }
  end

  guard 'rspec', :version => 2,
  :cli => "--color --format nested --fail-fast --drb --tag current",
  :notification => false,
  :all_after_pass => false,
  :all_on_start => false do

    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb')  { "spec" }

    # Rails example
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
    watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
    watch('spec/spec_helper.rb')                        { "spec" }
  end
end

group 'cucumber' do
  guard 'spork', :cucumber_env => { 'RAILS_ENV' => 'test' },
                 :rspec => false,
                 :cucumber => true,
                 :test_unit => false do
    watch('config/application.rb')
    watch('config/environment.rb')
    # watch(%r{^app/models/.+\.rb$})
    watch(%r{^extras/.+\.rb$})
    watch(%r{^config/environments/.+\.rb$})
    watch(%r{^config/initializers/.+\.rb$})
    watch('Gemfile')
    watch('Gemfile.lock')
  end

  guard 'cucumber', :cli => '--profile wip -c',
                    :notification => false,
                    :all_after_pass => false,
                    :all_on_start => false do
    watch(%r{^features/.+\.feature$})
    watch(%r{^features/support/.+$}) { 'features' }
    watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
  end
end
