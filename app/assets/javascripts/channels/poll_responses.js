$( document ).ready(function(){
	var stream_poll = $('#stream-poll-responses')
	
	if (stream_poll.length > 0){
		var poll_id = stream_poll.data("poll-id");
		var page_name = stream_poll.data("page-name");
		console.log("Connecting to poll stream " + poll_id + " on page " + page_name);
		setupPollStream(poll_id, page_name);
	}

	function setupPollStream(poll_id, page_name){
		App.responses = App.cable.subscriptions.create({channel: "ResponsesChannel", poll_id: poll_id, page_name: page_name}, {  
		  received: function(data) {
		  	//should include poll_choices, and tally_count
		  	console.log("received poll response on " + page_name)
		    this.updatePoll(data);
		  },

		  updatePoll: function(data) {
		  	$.each( data.poll_choices, function( index, poll_choice ){
  				var percent = String(Math.floor(poll_choice.poll_responses_count*100/data.tally_count));
  				$('#poll-choice-' + poll_choice.id + '-bg').width(percent + "%");
  				$('#poll-choice-' + poll_choice.id + '-count').html("(" + String(poll_choice.poll_responses_count) + ")");
			});
		  }
		});
	}
})