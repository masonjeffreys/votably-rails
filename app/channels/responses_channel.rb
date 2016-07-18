class ResponsesChannel < ApplicationCable::Channel  

  def subscribed
    stop_all_streams
    stream_from "polls:#{params[:poll_id]}:responses"
  end

end 