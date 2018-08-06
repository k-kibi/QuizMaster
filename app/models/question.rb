class Question < ApplicationRecord
  validates :content,
            presence: true

  validates :answer,
            presence: true

  # @param [String] users_answer
  # @return [TrueClass | FalseClass]
  def correct?(users_answer)
    if /\A\d+\z/ =~ self.answer
      self.answer == users_answer || self.answer.to_i.humanize == users_answer
    else
      self.answer == users_answer
    end
  end
end
