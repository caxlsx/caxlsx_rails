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

  def only_html; end

  def another
    render :xlsx => "index", :filename => "filename_test.xlsx"
  end

  def render_elsewhere
    case params[:type]
    when '1'
      render :xlsx => "home/index", :template => 'users/index'
    when '2'
      render :xlsx => "users/index", :template => 'users/index'
    when '3'
      render template: "users/index"
    when '4'
      render "users/index"
    else
      render :xlsx => "index"
    end
  end

  def render_file_path
    render :xlsx => Rails.root.join('app','views','users','index')
  end

  def withpartial
  end

  def useheader
    respond_to do |format|
      format.xlsx {
        if params[:set_direct]
          response.headers['Content-Disposition'] = "attachment; filename=\"filename_test.xlsx\""
        else
          render xlsx: "useheader", filename: "filename_test.xlsx"
        end
      }
    end
  end
end
