class SignupsController < ApplicationController

    rescue_from ActiveRecord::RecordInvalid, with: :signup_unprocessable

    def create 
        signup = Signup.create!(signup_params)
        render json: signup.activity, status: 201
    end

    private

    def signup_params
        params.permit(:camper_id, :activity_id, :time)
    end
    
    def signup_unprocessable(i)
        render json: { errors: i.record.errors.full_messages }, status: :unprocessable_entity
    end

end
