# Mock from pusher-http-ruby gem (Just for simulation purposes)
module Pusher
  extend ActiveSupport::Concern

  def trigger(channels, event_name, data, params = {})
    puts "Posting to: #{channels}, event: #{event_name}"
    puts "data: #{data}"
    puts "params: #{params}"
  end

end
