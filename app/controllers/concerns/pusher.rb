# MOCK PURPOSES ONLY
class Pusher
  def self.trigger(channels, event_name, data, params = {})
    puts "Posting to: #{channels}, event: #{event_name}"
    puts "data: #{data}"
    puts "params: #{params}"
    return true
  end
end
