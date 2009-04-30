# gems 
# default_environment["GEM_PATH"] = "/home/gieseler/gems:/usr/lib/ruby/gems/1.8"
# default_environment["GEM_HOME"] = "/home/gieseler/gems"

set :application, "chapman-events"

# configure the servers
role :app, "chapmanevents.info"
role :web, "chapmanevents.info"
role :db,  "chapmanevents.info", :primary => true

# server
set :user, "gieseler"
set :use_sudo, false
set :group_writable, false
set :deploy_to, "/home/#{user}/rails-apps/#{application}"

# scm configuration
set :scm, :git
set :scm_username, "supapuerco"
# set :scm_command, "~/bin/git"
set :repository,  "git@github.com:#{scm_username}/Eventinator.git"

namespace :passenger do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end
