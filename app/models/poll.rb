class Poll < ApplicationRecord
	validates :body, presence: true
	has_many :poll_choices, inverse_of: :poll
	has_many :poll_responses, through: :poll_choices

	accepts_nested_attributes_for :poll_choices, allow_destroy: true
end
