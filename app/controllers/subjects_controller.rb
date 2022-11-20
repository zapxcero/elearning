class SubjectsController < ApplicationController
  def index
    @user = current_user
    @subjects = @user.subjects
    @subject = Subject.new
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def create
    @user = current_user
    @subject = @user.subjects.build(subject_params)

    if @subject.save
      redirect_to subjects_path
    end
  end
  private

  def subject_params
    params.require(:subject).permit(:name, :description)
  end
end
