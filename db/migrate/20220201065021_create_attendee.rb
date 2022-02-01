class CreateAttendee < ActiveRecord::Migration[5.2]
  def change
    create_table :attendees do |t|
      t.references :user, foreign_key: true
      t.references :party, foreign_key: true 
      t.integer :role
    end
  end
end
