set :domain, 'middbites.com'
set :user, 'rails' # i made this
set :application, fetch(:domain)
set :repo_url, 'git@github.com:Jeloi/middbites.git'
set :branch, 'live'

# My options
set :port, '1026'


# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to,    "/home/rails/#{fetch(:domain)}"
set :scm, :git

set :format, :pretty
set :log_level, :debug
# set :pty, true

# Files and dirs linked between release
set :linked_files, %w{config/database.yml config/application.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :deploy do

  desc 'Restart Task'
  task :restart do
    invoke 'deploy:restart:unicorn'
  end

  namespace :restart do
    desc "Restart unicorn"
    task :unicorn do
      on roles(:web) do
        execute "service unicorn stop"
        execute "service unicorn start"
      end
    end

  end

  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     #   execute :rake, 'cache:clear'
  #     # end
  #   end
  # end

  desc "Sets permissions for Rails Application"
  task :set_permissions do
    puts "\n\n=== Setting Permissions! ===\n\n"
    run "chown -R #{fetch(:user)}:www-data #{fetch(:deploy_to)}"
  end

  namespace :db do
  
    desc "Create Production Database"
    task :create do
      puts "\n\n=== Creating the Production Database! ===\n\n"
      run "cd #{current_path}; rake db:create RAILS_ENV=production"
      system "cap deploy:set_permissions"
    end
  
    desc "Migrate Production Database"
    task :migrate do
      puts "\n\n=== Migrating the Production Database! ===\n\n"
      run "cd #{current_path}; rake db:migrate RAILS_ENV=production"
      system "cap deploy:set_permissions"
    end

    desc "Resets the Production Database"
    task :migrate_reset do
      puts "\n\n=== Resetting the Production Database! ===\n\n"
      run "cd #{current_path}; rake db:migrate:reset RAILS_ENV=production"
    end
    
    desc "Destroys Production Database"
    task :drop do
      puts "\n\n=== Destroying the Production Database! ===\n\n"
      execute "cd #{current_path}; rake db:drop RAILS_ENV=production"
      system "cap deploy:set_permissions"
    end

    desc "Moves the SQLite3 Production Database to the shared path"
    task :move_to_shared do
      puts "\n\n=== Moving the SQLite3 Production Database to the shared path! ===\n\n"
      run "mv #{current_path}/db/production.sqlite3 #{shared_path}/db/production.sqlite3"
      system "cap deploy:setup_symlinks"
      system "cap deploy:set_permissions"
    end
  
    desc "Populates the Production Database"
    task :seed do
      puts "\n\n=== Populating the Production Database! ===\n\n"
      run "cd #{current_path}; rake db:seed RAILS_ENV=production"
    end
  
  end


  after :finishing, 'deploy:cleanup'

end

namespace :sync do
  desc "Sync database.yml"
  task :db_yml do
    puts "\n\n=== Syncing database yaml to the production server! ===\n\n"
    unless File.exist?("config/database.yml")
      puts "There is no config/database.yml.\n "
      exit
    end
    system "rsync -vr -e 'ssh -p #{fetch(:port)}' --exclude='.DS_Store' config/database.yml  #{fetch(:user)}@#{fetch(:application)}:/#{fetch(:deploy_to)}/shared/config/"
  end

  desc "Sync application.yml"
  task :app_yml do
    puts "\n\n=== Syncing application yaml to the production server! ===\n\n"
    unless File.exist?("config/application.yml")
      puts "There is no config/application.yml.\n "
      exit
    end
    system "rsync -vr -e 'ssh -p #{fetch(:port)}' --exclude='.DS_Store' config/application.yml  #{fetch(:user)}@#{fetch(:application)}:/#{fetch(:deploy_to)}/shared/config/"
  end
end


namespace :sunspot do
  desc "Start sunspot on server"
  task :start do
    
  end
end



