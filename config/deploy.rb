require 'capistrano/ext/multistage'
require 'bundler/capistrano'
require 'thinking_sphinx/deploy/capistrano'

set :whenever_command, "bundle exec whenever"
require 'whenever/capistrano'

set :stages, %w(srv)
set :default_stage, "srv"
set :repository,  "git@github.com:balticit/bright-people.git"
set :scm, :git
set :branch, "master"

set :application, "bright-people"

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

set :keep_releases, 10



