class CreatePolls < ActiveRecord::Migration[5.0]
  def change
    create_table :polls do |t|
      t.references :user, foreign_key: true
      t.text :body, null: false

      t.timestamps
    end
  end
end
