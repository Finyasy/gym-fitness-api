# Extreme Fitness Centre Configuration
# This file contains the main configuration for the gym application

module GymConfig
  # Brand Information
  BRAND = {
    name: 'Extreme Fitness Centre',
    short_name: 'Extreme Fitness',
    slogan: 'Stronger Every Day'
  }.freeze

  # Theme Configuration
  THEME = {
    primary_color: '#0066CC',    # Primary Blue
    dark_color: '#004C99',       # Dark Blue
    light_color: '#3399FF',      # Light Blue
    accent_color: '#00AAFF'      # Accent Blue
  }.freeze

  # Contact Information (to be updated)
  CONTACT = {
    email: 'info@extremefitness.com',
    phone: '+1-555-0100',
    address: '123 Fitness Street, City, State 12345'
  }.freeze

  # Business Hours (to be updated)
  HOURS = {
    weekday: '5:00 AM - 11:00 PM',
    saturday: '6:00 AM - 10:00 PM',
    sunday: '7:00 AM - 9:00 PM'
  }.freeze

  # Application Settings
  APP = {
    frontend_url: ENV.fetch('FRONTEND_URL', 'http://localhost:3001'),
    api_version: 'v1'
  }.freeze

  # Helper method to get brand info
  def self.brand_info
    BRAND
  end

  # Helper method to get theme colors
  def self.theme_colors
    THEME
  end
end
