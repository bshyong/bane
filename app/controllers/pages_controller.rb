class PagesController < ApplicationController

  def home
  end

  def show
    @history = CitationHistory.find(params[:id])
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
        petitioner = lines[count] rescue 'Error occurred.'
        petitioner_string = petitioner.scan(/[A-Z]{2,}\W?/)
        unless (petitioner_string.last.to_s.downcase.strip=="inc.")
          petitioner_string[petitioner_string.split.length-1] = petitioner_string.last.to_s.gsub(/[,|.]/, "")
        end

        @petitioner = abbreviate_words(petitioner_string.join(" ")).titleize
        count += 1
      end
      while (@respondent.blank? && count < lines.length)
        respondent = lines[count] rescue 'Error occurred.'
        respondent_string = respondent.scan(/[A-Z]{2,}\W?/)
        unless (respondent_string.last.to_s.downcase.strip=="inc.")
          respondent_string[respondent_string.split.length-1] = respondent_string.last.to_s.gsub(/[,|.]/, "")
        end
        @respondent = abbreviate_words(respondent_string.join(" ")).titleize
        count += 1
      end
      @output = @petitioner.strip.titleize + ' v. ' + @respondent.strip.titleize + ", " + @reporter_number + " (#{@decision_year})." rescue "Error occurred!"
      @history = CitationHistory.create(:input => @input, :output => @output)
      if @output == "Error occurred!"
        @history.update_attribute(:correct, false)
      end
    end
  end

  def history
    @citation_histories = CitationHistory.find(:all, :order => 'created_at DESC')
  end

  def mark_citation
    return if (params[:v].blank? || params[:id].blank?)
    value = params[:v]
    CitationHistory.find(params[:id]).update_attribute(:correct, value)
    render :nothing => true
  end

private

def abbreviate_words(input = nil)
    return false if input.nil?
    result = String.new
    input.scan(/[\w]+/) do |word|
        ca = CommonAbbreviation.find_by_word(word.downcase)
        if ca.blank?
            result = input
        else
            result = input.downcase.gsub(word, ca.abbreviation)
        end
    end
    return result
end

end