class PagesController < ApplicationController

  def home
  end

  def status
    @errors = Array.new
    @correct = Array.new
    TestCase.all.each do |t|
      if t.output.squish == process_input_method(t.input)["output"].squish
        @correct << [t, process_input_method(t.input)]
      else
        @errors << [t, process_input_method(t.input)]
      end
    end
  end

  def show
    @history = CitationHistory.find(params[:id])
  end

  def process_input
  	unless params[:input].blank?
      results = process_input_method(params[:input])
      @output = results["output"]
      @petitioner = results["petitioner"]
      @respondent = results["respondent"]
      @decision_year = results["decision_year"]
      @reporter_number = results["reporter_number"]
      @input = results["input"]

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
      input.scan(/[A-Z]{2,}/) do |word|
          ca = CommonAbbreviation.find_by_word(word.downcase)
          if ca.blank?
              result = input if result.blank?
          else
              result = input.downcase.gsub!(word.downcase, ca.abbreviation)
          end
      end
      return result
  end

  def process_input_method(input=nil)
    unless input.blank?
      results = Hash.new
      results["input"] = input
      lines = Array.new
      count = 1
      input.lines.each do |l|
        lines << l
      end

      results["decision_year"] = input.scan(/\d{4}/).last
      results["reporter_number"] = lines[0] rescue 'Error occurred.'

      while (results["petitioner"].blank? && count < lines.length)
        petitioner = lines[count] rescue 'Error occurred.'
        petitioner_string = petitioner.scan(/[A-Z]{2,}\W?/)
        results["petitioner"] = abbreviate_words(petitioner_string.join(" ")).titleize
        unless (results["petitioner"].split.last.downcase.strip=="inc." rescue true)
          petitioner_dirty = results["petitioner"].split
          petitioner_dirty[petitioner_dirty.length-1] = petitioner_dirty.last.to_s.gsub(/[,|.]/, "")
          results["petitioner"] = petitioner_dirty.join(" ").titleize
        end
        count += 1
      end

      while (results["respondent"].blank? && count < lines.length)
        respondent = lines[count] rescue 'Error occurred.'
        respondent_string = respondent.scan(/[A-Z]{2,}\W?/)
        results["respondent"] = abbreviate_words(respondent_string.join(" ")).titleize
        unless (results["respondent"].split.last.downcase.strip=="inc." rescue true)
          respondent_dirty = results["respondent"].split
          respondent_dirty[respondent_dirty.length-1] = respondent_dirty.last.to_s.gsub(/[,|.]/, "")
          results["respondent"] = respondent_dirty.join(" ").titleize
        end
        count += 1
      end

      results["output"] = results['petitioner'].strip.titleize + ' v. ' + results['respondent'].strip.titleize + ", " + results['reporter_number'] + " (#{results['decision_year']})." rescue "Error occurred!"
      return results
    end
    return false
  end

end