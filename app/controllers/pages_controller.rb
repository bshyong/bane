class PagesController < ApplicationController

  def home
  end

  def process_input
  	unless params[:input].blank?
  		@input = params[:input]
  		lines = Array.new
      count = 1
  		@input.lines.each do |l|
  			lines << l
  		end
      @decision_year = @input.scan(/\d{4}/).last
  		@reporter_number = lines[0] rescue 'Error occurred.'
      while (@petitioner.blank? && count < lines.length)
        petitioner = lines[count].split(",")[0] rescue 'Error occurred.'
        @petitioner = abbreviate_words(petitioner.scan(/[A-Z]{2,}/).join(" ")).titleize
        count += 1
      end
      while (@respondent.blank? && count < lines.length)
        respondent = lines[count].split(",")[0] rescue 'Error occurred.'
        @respondent = abbreviate_words(respondent.scan(/[A-Z]{2,}/).join(" ")).titleize
        count += 1
      end
      @output = @petitioner.strip.titleize + ' v. ' + @respondent.strip.titleize + ", " + @reporter_number + " (#{@decision_year})." rescue "Error occurred!"
  	  CitationHistory.create(:input => @input, :output => @output)
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