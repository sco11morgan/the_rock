desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  puts "Checking cron"
  if Time.now.hour == 19 # run at midnight
    puts "Running cron..."
    Dir[File.join(RAILS_ROOT, 'db', 'fixtures', '*.rb')].sort.each { |fixture| load fixture }
  end
end
