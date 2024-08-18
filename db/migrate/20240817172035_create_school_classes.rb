class CreateSchoolClasses < ActiveRecord::Migration[7.1]
  def change
    create_table :school_classes do |t|
      t.integer :number
      t.string :letter
      t.integer :students_count

      t.timestamps
    end
  end
end
