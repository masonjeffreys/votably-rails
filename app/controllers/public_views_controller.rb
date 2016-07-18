class PublicViewsController < ApplicationController
  def show
  	@poll = Poll.includes(:poll_choices).find(params[:id])
    @tally_count = @poll.poll_choices.sum(:poll_responses_count)
    if @tally_count == 0
      @tally_count = 1
    end
  end
end
