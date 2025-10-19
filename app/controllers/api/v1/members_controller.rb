# frozen_string_literal: true

module Api
  module V1
    # MembersController - Handles member management
    class MembersController < ApplicationController
      # GET /api/v1/members
      def index
        members = Member.all.order(created_at: :desc)
        render json: members, status: :ok
      end

      # GET /api/v1/members/:id
      def show
        member = Member.find(params[:id])
        render json: member.as_json(include: :payments), status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Member not found' }, status: :not_found
      end

      # POST /api/v1/members
      def create
        member = Member.new(member_params)

        if member.save
          render json: member, status: :created
        else
          render json: { errors: member.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/members/:id
      def update
        member = Member.find(params[:id])

        if member.update(member_params)
          render json: member, status: :ok
        else
          render json: { errors: member.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Member not found' }, status: :not_found
      end

      # DELETE /api/v1/members/:id
      def destroy
        member = Member.find(params[:id])
        member.destroy
        render json: { message: 'Member deleted successfully' }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Member not found' }, status: :not_found
      end

      private

      def member_params
        params.require(:member).permit(:name, :email, :phone, :membership_type, :join_date, :status)
      end
    end
  end
end
