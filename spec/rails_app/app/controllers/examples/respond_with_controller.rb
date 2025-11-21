# frozen_string_literal: true

module Examples
  class RespondWithController < ApplicationController
    respond_to :xlsx

    def show
      respond_with(['a', 'b', 'c']) do |format|
        if Gem::Version.new("7.0") <= Rails.gem_version
          format.xlsx { render "show" }
        else
          format.xlsx { render "show.xlsx.axlsx" }
        end
      end
    end
  end
end
