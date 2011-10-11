desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  puts "Checking cron at #{Time.now.hour}"
  if Time.now.hour == 19 # run at 7pm
    puts "Running cron..."
    Dir[File.join(RAILS_ROOT, 'db', 'fixtures', '*.rb')].sort.each { |fixture| load fixture }
  end
end
