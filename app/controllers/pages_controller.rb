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
		@reporter_number = lines[0]
		@petitioner = lines[2].split(",")[0]
		@respondent = lines[4].split()[1]
	end
  end

end