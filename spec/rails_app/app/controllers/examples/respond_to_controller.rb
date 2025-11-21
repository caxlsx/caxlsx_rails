# frozen_string_literal: true

module Examples
  class RespondToController < ApplicationController
    def show
      respond_to do |format|
        format.html
        format.xlsx
      end
    end
  end
end
