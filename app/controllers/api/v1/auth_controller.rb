# frozen_string_literal: true

module Api
  module V1
    # AuthController - Handles admin authentication
    class AuthController < ApplicationController
      # POST /api/v1/auth/login
      def login
        admin = Admin.find_by(email: params[:email])

        if admin&.authenticate(params[:password])
          token = encode_token({ admin_id: admin.id })
          render json: {
            success: true,
            token: token,
            admin: {
              id: admin.id,
              name: admin.name,
              email: admin.email
            }
          }, status: :ok
        else
          render json: { success: false, error: 'Invalid email or password' }, status: :unauthorized
        end
      end

      # GET /api/v1/auth/verify
      def verify
        token = request.headers['Authorization']&.split(' ')&.last

        if token
          decoded = decode_token(token)
          if decoded
            admin = Admin.find_by(id: decoded[:admin_id])
            if admin
              render json: {
                success: true,
                admin: {
                  id: admin.id,
                  name: admin.name,
                  email: admin.email
                }
              }, status: :ok
              return
            end
          end
        end

        render json: { success: false, error: 'Invalid or expired token' }, status: :unauthorized
      end

      private

      def encode_token(payload)
        JWT.encode(payload, Rails.application.credentials.secret_key_base)
      end

      def decode_token(token)
        JWT.decode(token, Rails.application.credentials.secret_key_base)[0].symbolize_keys
      rescue JWT::DecodeError
        nil
      end
    end
  end
end
