CarrierWave.configure do |config|
  config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY'].to_s,
      aws_secret_access_key: ENV['AWS_SECRET_KEY'].to_s,
      region: 'ap-northeast-1'
  }

  config.fog_directory  = 'chatrailsreact'
  config.cache_storage = :fog
end
