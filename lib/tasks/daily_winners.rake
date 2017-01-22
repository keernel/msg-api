namespace :daily_winners do
  desc "Proccess daily winners"
  task :for_today => :environment do
    MostActiveUsersJob.perform_later
  end
end

