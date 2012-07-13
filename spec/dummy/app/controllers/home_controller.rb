#---
# Excerpted from "Crafting Rails Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails for more book information.
#---
class HomeController < ApplicationController
  def another
    render :pdf => "contents", :template => "home/index"
  end

  def index
    respond_to do |format|
      format.html
      format.xlsx
    end
  end
end