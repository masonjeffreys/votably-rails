class PollResponse < ApplicationRecord
	belongs_to :user
	belongs_to :poll_choice

	validates :user_id, presence: true
	validates :poll_choice_id, presence: true
end
