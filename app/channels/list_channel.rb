# frozen_string_literal: true

class ListChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'list_channel'
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
