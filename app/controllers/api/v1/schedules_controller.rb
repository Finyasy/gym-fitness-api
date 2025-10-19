# frozen_string_literal: true

module Api
  module V1
    # SchedulesController - Handles weekly schedule
    class SchedulesController < ApplicationController
      # GET /api/v1/schedules
      def index
        schedules = Schedule.all.order(:day, :time_slot)
        render json: schedules, status: :ok
      end

      # GET /api/v1/schedules/:id
      def show
        schedule = Schedule.find(params[:id])
        render json: schedule, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Schedule not found' }, status: :not_found
      end

      # POST /api/v1/schedules
      def create
        schedule = Schedule.new(schedule_params)

        if schedule.save
          render json: schedule, status: :created
        else
          render json: { errors: schedule.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/schedules/:id
      def update
        schedule = Schedule.find(params[:id])

        if schedule.update(schedule_params)
          render json: schedule, status: :ok
        else
          render json: { errors: schedule.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Schedule not found' }, status: :not_found
      end

      # DELETE /api/v1/schedules/:id
      def destroy
        schedule = Schedule.find(params[:id])
        schedule.destroy
        render json: { message: 'Schedule deleted successfully' }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Schedule not found' }, status: :not_found
      end

      private

      def schedule_params
        params.require(:schedule).permit(:day, :time_slot, :activity, :trainer, :capacity)
      end
    end
  end
end
