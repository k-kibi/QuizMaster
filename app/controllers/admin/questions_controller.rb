class Admin::QuestionsController < AdminController
  before_action :get_resource, only: %i(edit update destroy)

  def index
    page = params[:page] || 1
    per = params[:per] || 20
    @resources = Question.order(created_at: :desc)
                     .page(page).per(per)
  end

  def new
    @resource = Question.new
  end

  def create
    @resource = Question.new(question_params)
    @resource.save!
    redirect_to({ action: :index }, notice: 'New question added.')
  rescue ActiveRecord::RecordInvalid => ex
    flash.now[:alert] = 'An error occurred!'
    render :new
  end

  def edit

  end

  def update
    @resource.assign_attributes(question_params)
    @resource.save!
    redirect_to({ action: :index }, notice: "Question ##{@resource.id} has updated.")
  rescue ActiveRecord::RecordInvalid => ex
    flash.now[:alert] = 'An error occurred!'
    render :edit
  end

  def destroy
    @resource.destroy!
    redirect_to({ action: :index }, notice: "Question ##{@resource.id} has deleted.")
  end

  private

  def question_params
    params.require(:question).permit(:content, :answer)
  end

  def get_resource
    @resource = Question.find(params[:id])
  end
end
