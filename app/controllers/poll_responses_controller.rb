class PollResponsesController < ApplicationController

  def new
    response.headers['X-Csrf-Token'] = form_authenticity_token #added for loader.io to get csrf var
    @poll = Poll.includes(:poll_choices).find(params[:id])
    #check for previous response. Redirect to polls#show if it exists
    @previous_poll_response = @poll.poll_responses.where("user_id = ?", current_user.id)
    redirect_to @poll if @previous_poll_response.count > 0
    @poll_response = @poll.poll_responses.build()
  end

  def create
    @poll_choice = PollChoice.includes(:poll).find(params[:poll_choice_id])
    #check for previous response. Redirect to polls#show if it exists
    @previous_poll_response = @poll_choice.poll.poll_responses.where("user_id = ?", current_user.id)
    redirect_to @poll and return if @previous_poll_response.count > 0

    tally = TallyPollResponse.new(@poll_choice, current_user.id)

    if tally.save_and_increment
      #prepare data for the ActionCable broadcast
      @poll = Poll.includes(:poll_choices).find(@poll_choice.poll_id)
      @tally_count = @poll.poll_choices.sum(:poll_responses_count)
      #add data to the correct broadcast for this poll
      ActionCable.server.broadcast "polls:#{@poll.id}:responses",
          poll_choices: @poll.poll_choices,
          tally_count: @tally_count
      redirect_path = poll_path(@poll)
    else
      redirect_path = root_path
    end

    respond_to do |format|
      format.html { redirect_to(redirect_path) }
      format.js
    end
    
  end

end