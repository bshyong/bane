class CreateCommonAbbreviations < ActiveRecord::Migration
  def change
    create_table :common_abbreviations do |t|
      t.string :word
      t.string :abbreviation

      t.timestamps
    end
  end
end
