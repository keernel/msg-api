uri = ENV["REDISTOGO_URL"] || "redis://localhost:6379/"
$redis_msg = Redis.new(:url => uri)
