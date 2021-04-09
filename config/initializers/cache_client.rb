redis_options = YAML.load_file(File.join(Rails.root, 'config', 'redis.yml'))
$redis_client = Redis.new(redis_options.symbolize_keys)
