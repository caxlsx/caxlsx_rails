# frozen_string_literal: true

module Examples
  class RenderTemplateController < ApplicationController
    def show
      case params[:id]
      when '1'
        render xlsx: "render_template/bugs", template: 'examples/render_template/bunny'
      when '2'
        render xlsx: "render_template/bunny", template: 'examples/render_template/bunny'
      when '3'
        render template: "examples/render_template/bunny"
      when '4'
        render "examples/render_template/bunny"
      when '5'
        render xlsx: "render_template/bunny"
      end
    end
  end
end
