class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_bad_message
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_bad_message
    #GET /instructors
    def index
        instructors = Instructor.all
        render json: instructors
    end
    #GET /instructors/:id
    def show
        instructor = Instructor.find_by(id: params[:id])
        render json: instructor
    end
    #POST /instructors
    def create
        instructor = Instructor.create!(instructors_params)
        render json: instructor, status: :created
    end
    #UPDATE /instructors/:id
    def update
        instructor = Instructor.find(params[:id])
        instructor.update!(instructors_params)
        render json: instructor
    end
    #DELETE /instructors/:id
    def destroy
        instructor = Instructor.find(params[:id])
        instructor.destroy
        head :no_content
    end

    private
    def instructors_params
        params.permit(:name)
    end
    def record_not_found_bad_message(exception)
        render json: { error: "#{exception.model} not found" }, status: :not_found
    end
    def record_invalid_bad_message
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
