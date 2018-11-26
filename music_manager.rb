# frozen_string_literal: true

require 'set'

class MusicManager
  attr_reader :albums, :artists, :played, :unplayed

  def initialize
    @albums = []
    @albums_index = {}

    @artists = []
    @artists_index = {}

    @artist_albums = {}
    @album_artist = {}

    @played = Set.new
    @unplayed = Set.new
  end

  def add(artist, album)
    return false if @albums_index.key?(album)

    @artists << artist unless @artists.include?(artist)
    artist_index = @artists.index(artist)
    @artists_index[artist] = artist_index

    @albums << album
    album_index = @albums.index(album)
    @albums_index[album] = album_index

    @artist_albums[artist_index] ||= []
    @artist_albums[artist_index] << album_index

    @album_artist[album_index] = artist_index

    @unplayed.add(album_index)

    true
  end

  def play(album)
    album_id = @albums_index[album]

    return true if @played.include?(album_id)
    return false unless @unplayed.include?(album_id)

    @unplayed.delete(album_id)
    @played.add(album_id)

    true
  end

  def select_by_artist(artist, unplayed)
    album_ids = @artist_albums[@artists_index[artist]]
    album_ids = filter_unplayed(album_ids) if unplayed

    serialize(album_ids)
  end

  def filter_unplayed(album_ids)
    album_ids.select { |album_id| @unplayed.include?(album_id) }
  end

  def select_all(unplayed)
    album_ids = @album_artist.keys
    album_ids = filter_unplayed(album_ids) if unplayed

    serialize(album_ids)
  end

  def serialize(album_ids)
    return [] if album_ids.nil?

    album_ids.each_with_object([]) do |album_id, result|
      artist_id = @album_artist[album_id]

      result << {
        artist: @artists[artist_id],
        album: @albums[album_id],
        played: @played.include?(album_id)
      }
    end
  end
end
