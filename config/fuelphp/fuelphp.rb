load 'deploy'

set :shared_children, [ 'fuel/app/logs', ]
set :normalize_asset_timestamps, false
set :group_writable, false
set :use_sudo, false

namespace :deploy do
  after 'deploy:setup', :except => { :no_release => true } do
    run "chmod -R u=rwX,go=rX #{deploy_to}"
    run "chgrp -R apache #{shared_path}/logs"
    run "chmod -R g+w #{shared_path}/logs"
  end

  after 'deploy:finalize_update', :except => { :no_release => true } do
    run "chmod -R u=rwX,go=rX #{latest_release}"
    run "chgrp -R apache #{latest_release}/fuel/app/{cache,tmp}"
    run "chmod -R g+w #{latest_release}/fuel/app/{cache,tmp}"
  end

  after 'deploy:update', :except => { :no_release => true } do
    cleanup
  end

  namespace :web do
    [:enable, :disable].each {|t| task(t) {}}
  end
  [:cold, :migrate, :migrations, :restart, :start, :stop, :symlink, :upload].each {|t| task(t) {}}
end
