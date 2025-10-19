# frozen_string_literal: true

module Api
  module V1
    # PaymentsController - Handles payment records
    class PaymentsController < ApplicationController
      # GET /api/v1/payments
      def index
        payments = Payment.includes(:member).all.order(payment_date: :desc)
        render json: payments.as_json(include: { member: { only: [:id, :name] } }), status: :ok
      end

      # GET /api/v1/payments/:id
      def show
        payment = Payment.includes(:member).find(params[:id])
        render json: payment.as_json(include: :member), status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Payment not found' }, status: :not_found
      end

      # POST /api/v1/payments
      def create
        payment = Payment.new(payment_params)

        if payment.save
          render json: payment.as_json(include: :member), status: :created
        else
          render json: { errors: payment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/payments/:id
      def update
        payment = Payment.find(params[:id])

        if payment.update(payment_params)
          render json: payment.as_json(include: :member), status: :ok
        else
          render json: { errors: payment.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Payment not found' }, status: :not_found
      end

      # DELETE /api/v1/payments/:id
      def destroy
        payment = Payment.find(params[:id])
        payment.destroy
        render json: { message: 'Payment deleted successfully' }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Payment not found' }, status: :not_found
      end

      private

      def payment_params
        params.require(:payment).permit(:member_id, :amount, :payment_date, :payment_method, :status, :notes)
      end
    end
  end
end
