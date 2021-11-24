# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

set :application, "sycall"
set :repo_url, "git@github.com:Toufup/sycall.git"
set :rbenv_ruby, File.read('.ruby-version').strip
set :branch, ENV['BRANCH'] || "master"

# Nginxの設定ファイル名と置き場所を修正
set :nginx_config_name, "#{fetch(:application)}.conf"
set :nginx_sites_enabled_path, "/etc/nginx/conf.d"

append :linked_files, "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "node_modules"
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
namespace :deploy do
  # 1. capistranoを実行したマシン側でコンパイルする
  task :compile_assets_locally do
    run_locally do
      with rails_env: fetch(:stage) do
        execute 'bundle exec rails assets:precompile'
      end
    end
  end

  # 2. webpackerとsprocketsで生成したファイルをそれぞれzipする
  task :zip_assets_locally do
    run_locally do
      execute 'tar -zcvf ./tmp/assets.tar.gz ./public/assets 1> /dev/null'
      execute 'tar -zcvf ./tmp/packs.tar.gz ./public/packs 1> /dev/null'
    end
  end

  # 3. zip後のファイルをupload!でWebサーバーに送り込む。
  task :send_assets_zip do
    on roles(:web) do |_host|
      upload!('./tmp/assets.tar.gz', "#{release_path}/public/")
      upload!('./tmp/packs.tar.gz', "#{release_path}/public/")
    end
  end

  # 4. Webサーバー内でunzipする
  task :unzip_assets do
    on roles(:web) do |_host|
      execute "cd #{release_path}; tar -zxvf #{release_path}/public/assets.tar.gz 1> /dev/null"
      execute "cd #{release_path}; tar -zxvf #{release_path}/public/packs.tar.gz 1> /dev/null"
    end
  end
end

# どのタイミングでタスクが呼ばれるのかを記述する。
before 'deploy:updated', 'deploy:compile_assets_locally'
before 'deploy:updated', 'deploy:zip_assets_locally'
before 'deploy:updated', 'deploy:send_assets_zip'
before 'deploy:updated', 'deploy:unzip_assets'
