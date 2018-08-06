class Api::QuizzesController < ApiController
  before_action :get_resource, only: %i(show answer)
  def index
    @resources = Question.all
  end

  def show
  end

  def answer
    @correct = @resource.correct?(params[:answer])
  end

  private

  def get_resource
    @resource = Question.find(params[:id])
  end
end
