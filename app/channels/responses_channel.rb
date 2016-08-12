class ResponsesChannel < ApplicationCable::Channel  

  def subscribed
    stop_all_streams
    puts "###### Connected client on #{params[:page_name]}"
    stream_from "polls:#{params[:poll_id]}:responses"
  end

end 