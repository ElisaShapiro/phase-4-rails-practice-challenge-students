class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_bad_message
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_bad_message
    #GET /students
    def index
        students = Student.all
        render json: students
    end
    #GET /students/:id
    def show
        student = Student.find_by(id: params[:id])
        render json: student
    end
    #POST /students
    def create
        student = Student.create!(students_params)
        render json: student, status: :created
    end
    #UPDATE /students/:id
    def update
        student = Student.find(params[:id])
        student.update!(students_params)
        render json: student
    end
    #DELETE /students/:id
    def destroy
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    end

    private
    def students_params
        params.permit(:name, :major, :age, :instructor_id)
    end
    def record_not_found_bad_message(exception)
        render json: { error: "#{exception.model} not found" }, status: :not_found
    end
    def record_invalid_bad_message
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
