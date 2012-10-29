class PagesController < ApplicationController
  def home
  end

  def process_input
  	unless params[:input].blank?
  		p = params[:input]

  		@output = String.new
  		@input = p
  	end
  end

end