# frozen_string_literal: true

class LessonsController < ApplicationController
  layout 'dashboards'

  before_action :authenticate_user!
  before_action :set_subject, only: [:create, :destroy, :edit, :update]

  def index
    return @subjects = current_user.student_subjects if current_user.student?

    @subjects = current_user.teacher_subjects
    @subject = Subject.new
  end

  def create
    @subject.lessons.create(lesson_params)
    redirect_to @subject
  end

  def destroy
    @lesson.destroy
    redirect_to @subject, status: :see_other
  end

  def edit
  end

  def update
    @lesson.update(lesson_params)
    redirect_to @subject, status: :see_other
  end

  private

  def lesson_params
    params.require(:lesson).permit(:name, :description, :url)
  end
  
  def set_subject
    @subject = authorize Subject.find(params[:subject_id])
    @lesson = @subject.lessons.find(params[:id])
  end
end
