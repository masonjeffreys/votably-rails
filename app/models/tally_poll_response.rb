class TallyPollResponse
	attr_accessor :poll_choice
	attr_accessor :user_id

	def initialize(poll_choice, user_id)
		@poll_choice = poll_choice
		@user_id = user_id
	end

	def save_and_increment(val = 1)
		poll_response = @poll_choice.poll_responses.build
		poll_response.user_id = @user_id
		if poll_response.save
			@poll_choice.increment!(:poll_responses_count, val)
			true
		else
			false
		end
	end
end