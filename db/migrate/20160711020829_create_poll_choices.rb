class CreatePollChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :poll_choices do |t|
      t.references :poll, foreign_key: true
   	  t.string :body, null: false
   	  t.integer :poll_responses_count, null: false, default: 0
      
      t.timestamps
    end
  end
end
