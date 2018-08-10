require 'rails_helper'

RSpec.describe Admin::QuestionsController, type: :controller do
  let(:question) { create :question }

  describe "GET #index" do
    before do
      get :index
    end
    it "returns http success" do
      expect(response).to have_http_status(:successful)
    end
  end

  describe "GET #new" do
    before do
      get :new
    end
    it "returns http success" do
      expect(response).to have_http_status(:successful)
    end
  end

  describe "GET #edit" do
    before do
      question
      get :edit, params: { id: question.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:successful)
    end
  end

  describe "POST #create" do
    let(:content) { 'Question text' }
    let(:answer) { 'Answer' }
    before do
      post :create, params: { question: { content: content, answer: answer } }
    end
    subject { Question.order(created_at: :desc).last }

    it "creates new question" do
      is_expected.to have_attributes(content: 'Question text', answer: 'Answer')
    end
  end

  describe "PUT #update" do
    let(:content) { 'Updated question text' }
    let(:answer) { 'Renewal answer' }
    before do
      question
      put :update, params: { id: question.id, question: { content: content, answer: answer } }
    end
    subject { question.reload }

    it 'updates question' do
      is_expected.to have_attributes(content: 'Updated question text', answer: 'Renewal answer')
    end
  end

  describe "DELETE #destroy" do
    before do
      question
      delete :destroy, params: { id: question.id }
    end
    subject { question.reload }

    it 'deletes question' do
      expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
