require 'rails_helper'

RSpec.describe Api::QuestionsController, type: :controller do
  render_views

  describe '#index' do
    let(:questions) { create_list :question, 10 }
    before do
      questions
      get :index, format: :json
    end
    subject { JSON.parse(response.body) }

    it { expect(subject.size).to eq 10 }
  end

  describe '#answer' do
    let(:question) { create :question, answer: '5' }
    let(:answer) { '5' }
    before do
      question
      post :answer, params: { id: question.id, answer: answer }, format: :json
    end
    subject { JSON.parse(response.body).with_indifferent_access[:correct] }

    it { is_expected.to be_truthy }

    context 'when answer is number, numeric word is allowed' do
      let(:answer) { 'five' }
      it { is_expected.to be_truthy }
    end

    context 'when answer is incorrect' do
      let(:answer) { '6' }
      it { is_expected.to be_falsey }
    end

    context 'when answer is incorrect(word)' do
      let(:answer) { 'six' }
      it { is_expected.to be_falsey }
    end
  end
end
