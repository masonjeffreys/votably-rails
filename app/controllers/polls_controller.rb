class PollsController < ApplicationController

  def new
  	@poll = Poll.new
  end

  def show
    @poll = Poll.includes(:poll_choices).find(params[:id])
    @tally_count = @poll.poll_choices.sum(:poll_responses_count)
    if @tally_count == 0
      @tally_count = 1
    end
  end

  def create
    @poll = current_user.polls.create(poll_params)
    if @poll.save
      redirect_to public_path(@poll)
    else
      render 'new'
    end
  end

private

    def poll_params
      params.require(:poll).permit(:body, poll_choices_attributes: [:id, :poll, :poll_id, :body, :_destroy])
    end

end
