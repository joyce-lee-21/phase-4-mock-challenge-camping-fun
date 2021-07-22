class SignupsController < ApplicationController

    def create
        signup = Signup.create!(signup_params)
        render json: signup.activity, except: [:created_at, :updated_at], status: :created
    rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    private

    def signup_params
        params.permit(:time, :camper_id, :activity_id)
    end

end
