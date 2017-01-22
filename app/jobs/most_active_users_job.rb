class MostActiveUsersJob < ApplicationJob
  queue_as :default

  def perform
    puts "Working..."
  end
end
