class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :surname
      t.integer :class_id
      t.integer :school_id

      t.timestamps
    end
  end
end
