class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :camper_not_found
rescue_from ActiveRecord::RecordInvalid, with: :camper_unprocessable

    def index 
        campers = Camper.all
        render json: campers
    end

    def show 
        camper = Camper.find(params[:id])
        render json: camper, serializer: CamperShowSerializer
    end

    def create 
        camper = Camper.create!(camper_params)
        render json: camper, status: 201
    end

    private

    def camper_not_found
        render json: { error: "Camper not found" }, status: 404
    end

    def camper_params
        params.permit(:name, :age)
    end

    def camper_unprocessable(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
