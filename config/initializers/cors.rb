# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin Ajax requests.

# Read more: https://github.com/cyu/rack-cors

# Extreme Fitness Centre - CORS Configuration
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Allow requests from the React frontend
    if Rails.env.development?
      # In development, allow any origin on the local network
      origins '*'
    else
      # In production, allow frontend URL from environment variable
      frontend_url = ENV.fetch('FRONTEND_URL', 'https://your-frontend-app.netlify.app')
      origins frontend_url,
              /https:\/\/.*\.netlify\.app$/,  # Allow any Netlify preview URLs
              /https:\/\/.*\.vercel\.app$/     # Allow any Vercel preview URLs
    end

    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
end
