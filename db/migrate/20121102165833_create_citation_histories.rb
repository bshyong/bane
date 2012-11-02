class CreateCitationHistories < ActiveRecord::Migration
  def change
    create_table :citation_histories do |t|
      t.text :input
      t.text :output

      t.timestamps
    end
    add_index :citation_histories, :created_at
  end
end
