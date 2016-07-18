$( document ).ready(function(){
	var poll_id = $('#stream-poll-responses').data("poll-id");
	if (typeof poll_id !== "undefined"){
		console.log("Connecting to poll stream " + poll_id);
		setupPollStream(poll_id);
	}

	function setupPollStream(poll_id){
		App.responses = App.cable.subscriptions.create({channel: "ResponsesChannel", poll_id: poll_id}, {  
		  received: function(data) {
		  	//should include poll_choices, and tally_count
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