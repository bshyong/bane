class PagesController < ApplicationController

  def home
  end

  def process_input
  	unless params[:input].blank?
  		@input = params[:input]
  		lines = Array.new
  		@input.lines.each do |l|
  			lines << l
  		end
      @decision_year = /(decided).+\d{4}/i.match(@input) {|m| /\d{4}/.match(m.to_s)}
  		@reporter_number = lines[0] rescue 'Error occurred.'
  		petitioner = lines[2].split(",")[0] rescue 'Error occurred.'
      @petitioner = abbreviate_words(petitioner).titleize
  		respondent = lines[4].split()[1] rescue 'Error occurred.'
      @respondent = abbreviate_words(respondent).titleize
      @output = @petitioner.strip.titleize + ' v. ' + @respondent.strip.titleize + ", " + @reporter_number + " (#{@decision_year})."
  	end
  end

private

def abbreviate_words(input = nil)
    return false if input.nil?
    result = String.new
    input.scan(/[\w']+/) do |word|
        ca = CommonAbbreviation.find_by_word(word.downcase)
        if ca.blank?
            result += (word + ' ')
        else
            result += (ca.abbreviation + ' ')
        end
    end
    return result
end

end