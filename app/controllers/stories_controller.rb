class StoriesController < ApplicationController
  def initialize
    @client = Marvelite::API::Client.new(public_key: ENV['public_key'],
                                         private_key: ENV['private_key'])
    super
  end

  def index
    response = @client.characters(name: 'Captain America')
    @captain = response.data['results'].first

    response = @client.stories(limit: 100, characters: @captain[:id])
    @story = response.data['results'].sample
    @attributtion_text = response.attributionHTML

    response = @client.story_characters(@story[:id])
    @characters = response.data[:results]
  end
end
