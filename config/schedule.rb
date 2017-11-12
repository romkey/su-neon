# from https://gist.github.com/mdesantis/5356195

set :env_path,    '"$HOME/.rbenv/shims":"$HOME/.rbenv/bin"'

job_type :rake,   %q{ cd :path && PATH=:env_path:"$PATH" RAILS_ENV=:environment bundle exec rake :task --silent :output }
job_type :runner, %q{ cd :path && PATH=:env_path:"$PATH" bin/rails runner -e :environment ':task' :output }
job_type :script, %q{ cd :path && PATH=:env_path:"$PATH" RAILS_ENV=:environment bundle exec script/:task :output }

every 1.hour do
  runner "ScanHeadlinesJob.perform_now"
end
