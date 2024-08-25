class StudentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    @students = Student.all
    render json: @students
  end

  def create
    @student = Student.new(student_params)

    if @student.save
      token = generate_token(@student.id)
      Rails.logger.debug "Generated token: #{token}"
      response.headers['X-Auth-Token'] = token
      render json: @student, status: :created
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  def destroy
    Rails.logger.debug "Удаление студента с ID: #{params[:id]}"
    Rails.logger.debug "Токен, переданный в запросе: #{request.headers['Authorization']}"

    student = Student.find(params[:id])
    token = request.headers['Authorization']&.split(' ')&.last

    if token_valid?(token, student.id)
      Rails.logger.debug "Токен валиден, студент будет удален"
      student.destroy
      head :no_content
    else
      Rails.logger.debug "Токен невалиден, запрос отклонен"
      head :unauthorized
    end
  end

  private

  def token_valid?(token, student_id)
    expected_token = generate_token(student_id)
    ActiveSupport::SecurityUtils.secure_compare(token, expected_token)
  end

  def student_params
    params.require(:student).permit(:first_name, :last_name, :surname, :class_id, :school_id)
  end

  def generate_token(student_id)
    Digest::SHA256.hexdigest("#{student_id}#{Rails.application.credentials.secret_key_base}")
  end
end
