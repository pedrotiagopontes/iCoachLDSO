namespace :db do
  desc "Recreate everythin"
  task :recreate => [:drop, :migrate, :seed] do
  # desc "Recreate everything from scratch including pre-populated data"
  end
end
