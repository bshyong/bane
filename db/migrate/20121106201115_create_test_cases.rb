class CreateTestCases < ActiveRecord::Migration
  def change
    create_table :test_cases do |t|
      t.text :input
      t.text :output

      t.timestamps
    end
  end
end
