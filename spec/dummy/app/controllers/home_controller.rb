#---
# Excerpted from "Crafting Rails Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails for more book information.
#---
class HomeController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def another
    render :xlsx => "index", :filename => "filename_test.xlsx"
  end

  def render_elsewhere
    render :xlsx => "/users/index"
  end

  def withpartial
  end

  def useheader
    respond_to do |format|
      format.xlsx {
        if params[:set_direct]
          response.headers['Content-Disposition'] = "attachment; filename=\"filename_test.xlsx\""
        else
          render xlsx: "useheader", disposition: "attachment", filename: "filename_test.xlsx"
        end
      }
    end
  end
end
