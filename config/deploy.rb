# Change these

set :application, 'tnd'
set :repo_url, 'https://github.com/Iverson/tnd-m.git'
set :deploy_to, '/www/tnd'
set :log_level, :debug
set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{tmp/sockets tmp/pids log public/system}
# set :sockets_path, Pathname.new("#{fetch(:deploy_to)}/shared/tmp/sockets/")

# set :bundle_flags, '--deployment'

namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
