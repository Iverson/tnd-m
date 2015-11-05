namespace :db do
  desc 'Runs rake db:seed'
  task :seed do
    puts "\n=== Seeding Database ===\n"
    on primary :db do
      within current_path do
        with rails_env: fetch(:stage) do
          execute :rake, 'db:seed'
        end
      end
    end
  end

  desc 'Export db dump from server'
  task :export do
    puts "\n=== Export dump from server ===\n"
    env = fetch(:rails_env)
    db_tmp_config_local_path = "tmp/database_#{env}.yml"
    dump_server_tmp_path     = "#{shared_path}/dump_#{env}.sql"
    dump_local_path          = "tmp/dump_#{env}.sql"

    on primary :db do
      download! "#{shared_path}/config/database.yml", db_tmp_config_local_path
      remote_db_config = YAML::load(IO.read(db_tmp_config_local_path))["#{env}"]
      execute "pg_dump --verbose --clean #{remote_db_config["database"]} > #{dump_server_tmp_path}"
      download! dump_server_tmp_path, dump_local_path
      # execute :rm, dump_server_tmp_path
    end

    %x(rm #{db_tmp_config_local_path})
  end
end