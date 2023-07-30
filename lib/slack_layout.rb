# frozen_string_literal: true

require_relative "slack_layout/version"
require "slack-ruby-block-kit"

class SlackLayout
  attr_accessor :layout

  def initialize
    Slack::BlockKit.blocks do |layout|
      @layout = layout
    end
    build
  end

  def build
    blocks
  end

  def blocks
    raise NotImplementedError
  end

  def as_json
    layout.as_json
  end

  def method_missing(method, *args, &block)
    layout.send(method, *args, &block)
  end
end
