class Question < ApplicationRecord
  validates :content,
            presence: true

  validates :answer,
            presence: true

  # @param [String] users_answer
  # @return [TrueClass | FalseClass]
  def correct?(users_answer)
    return true if self.answer == users_answer

    if /\d+/ =~ self.answer
      return true if self.answer.gsub(/(\d+)/) { $1.to_i.humanize } == users_answer
    end

    false
  end
end
