class CreatePollResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :poll_responses do |t|
    	t.references :user, foreign_key: true
    	t.references :poll_choice, foreign_key: true
    	t.string :body
      t.timestamps
    end
  end
end
