class CreateCommonAbbreviations < ActiveRecord::Migration
  def change
    create_table :common_abbreviations do |t|
      t.string :word
      t.string :abbreviation

      t.timestamps
    end
    add_index :common_abbreviations, :word
    add_index :common_abbreviations, :abbreviation
  end
end
