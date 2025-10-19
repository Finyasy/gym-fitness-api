class CreateMembers < ActiveRecord::Migration[7.2]
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :membership_type
      t.date :join_date
      t.string :status

      t.timestamps
    end
  end
end
