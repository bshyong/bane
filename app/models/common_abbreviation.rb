class CommonAbbreviation < ActiveRecord::Base

    validates_uniqueness_of :word, :case_sensitive => false

end
