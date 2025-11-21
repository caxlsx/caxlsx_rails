# frozen_string_literal: true

module Examples
  class FileNameController < ApplicationController
    def show
      if params[:set_content_disposition]
        response.headers['Content-Disposition'] = 'attachment; filename="new_file_name.xlsx"'
      else
        render xlsx: 'show', filename: 'new_file_name.xlsx'
      end
    end
  end
end
