$redis_msg = Redis::Namespace.new("msg-api", :redis => Redis.new)
