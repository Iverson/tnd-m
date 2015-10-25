server '127.0.0.1', user: 'deploy', port: 2200, roles: [:web, :app, :db], primary: true
set :branch, ENV['BRANCH'] || 'develop'