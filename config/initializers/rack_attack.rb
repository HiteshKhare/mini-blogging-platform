class Rack::Attack
  # Block requests from a single IP if they exceed 5 requests per minute
  throttle('req/ip', limit: 5, period: 1.minute) do |req|
    req.ip if req.path.start_with?('/api/') # Apply to API requests only
  end
end
