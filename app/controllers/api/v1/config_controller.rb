# frozen_string_literal: true

module Api
  module V1
    # ConfigController - Returns gym configuration and branding information
    class ConfigController < ApplicationController
      # GET /api/v1/config
      def index
        render json: {
          brand: GymConfig.brand_info,
          theme: GymConfig.theme_colors,
          contact: GymConfig::CONTACT,
          hours: GymConfig::HOURS
        }
      end

      # GET /api/v1/config/brand
      def brand
        render json: GymConfig.brand_info
      end

      # GET /api/v1/config/theme
      def theme
        render json: GymConfig.theme_colors
      end
    end
  end
end
