load 'config/fuelphp/fuelphp'
require 'capistrano/ext/multistage'

set :application, 'cme-drtenshoku.jp'
set :deploy_to do "/home/#{user}/deploy/#{application}" end

set :ssh_options, { :keys => "#{ENV['HOME']}/.ssh/user@cme", }

set :deploy_via, :copy
set :repository, '.'
set :scm, :none
set :copy_exclude, [ '.git*', '*/.git*', ]
