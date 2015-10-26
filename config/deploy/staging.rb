server '109.234.34.240', user: 'deploy', port: 22, roles: [:web, :app, :db], primary: true
set :branch, ENV['BRANCH'] || 'develop'
