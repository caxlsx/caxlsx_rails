# frozen_string_literal: true

require 'spec_helper'

describe ActionController::Renderers do
  it 'is registered' do
    ActionController::Renderers::RENDERERS.include?(:xlsx)
  end

  it 'has mime type' do
    expect(Mime[:xlsx].to_sym).to eq(:xlsx)
    expect(Mime[:xlsx].to_s).to eq("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
  end
end
