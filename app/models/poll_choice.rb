class PollChoice < ApplicationRecord
	belongs_to :poll, inverse_of: :poll_choices
	has_many :poll_responses

	validates_presence_of :poll
end
