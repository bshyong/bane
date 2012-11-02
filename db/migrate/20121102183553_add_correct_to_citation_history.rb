class AddCorrectToCitationHistory < ActiveRecord::Migration
  def change
    add_column :citation_histories, :correct, :boolean
    add_index :citation_histories, :correct
  end
end
