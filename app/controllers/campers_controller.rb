class CampersController < ApplicationController

    def index
        campers = Camper.all
        render json: campers, except: [:created_at, :updated_at]
    end

    def show
        campers = Camper.find_by(id: params[:id])
        if campers
            render json: campers, include: :activities, except: [:created_at, :updated_at]
        else
            render json: {error: "Camper not found"}, status: :not_found
        end
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    private

    def camper_params
        params.permit(:name, :age)
    end

end
