require 'capistrano/ext/multistage'
require 'bundler/capistrano'
require 'thinking_sphinx/deploy/capistrano'

set :whenever_command, "bundle exec whenever"
set :whenever_identifier, defer { "#{application}_#{stage}" }
require 'whenever/capistrano'

set :stages, %w(srv-dev staging production)
set :default_stage, "staging"
set :repository,  "git@github.com:balticit/bright-people.git"
set :scm, :git
set :application, "bright-people"
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

