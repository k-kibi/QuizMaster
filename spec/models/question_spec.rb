require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { create :question, content: 'content', answer: '5' }

  describe 'validates' do
    let(:question) { build :question }
    subject { question.valid? }

    it { is_expected.to be_truthy }

    it 'content must be present' do
      question.content = ''
      is_expected.to be_falsey
    end

    it 'answer must be present' do
      question.answer = ''
      is_expected.to be_falsey
    end
  end

  describe '#correct?' do
    let(:users_answer) { '5' }
    subject { question.correct?(users_answer) }

    it { is_expected.to be_truthy }

    context 'when answer is text' do
      let(:users_answer) { 'five' }
      it { is_expected.to be_truthy }
    end

    context 'when answer is wrong' do
      let(:users_answer) { '6' }
      it { is_expected.to be_falsey }
    end
  end
end
