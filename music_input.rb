# frozen_string_literal: true

require_relative 'music_manager'
require_relative 'music_viewer'

class MusicInput
  def initialize(manager)
    @manager = manager
  end

  def process_input(input)
    if input.start_with?('show all', 'show unplayed')
      process_show(input)
    elsif input.start_with?('play')
      process_play(input)
    elsif input.start_with?('add')
      process_add(input)
    else
      puts 'Invalid Command'
      print_help
    end
  end

  def process_add(input)
    matches = input.scan(/"([^"]+)"\s+"([^"]+)"/).first
    return print_help if matches.nil?

    album = matches[0]
    artist = matches[1]

    if @manager.add(artist, album)
      "Added \"#{album}\" by #{artist}"
    else
      'Nothing Added: Album already exists'
    end
  end

  def process_show(input)
    unplayed = input.include?('unplayed')
    by_artist = input.scan(/by\s+"([^"]+)"/).first&.first

    results = if by_artist
                @manager.select_by_artist(by_artist, unplayed)
              else
                @manager.select_all(unplayed)
              end

    MusicViewer.display(results, unplayed)
  end

  def process_play(input)
    matches = input.scan(/"([^"]+)"/).first
    return print_help if matches.nil?

    album = matches[0]

    if @manager.play(album)
      "You're listening to \"#{album}\""
    else
      "Album #{album} does not exist"
    end
  end

  def print_help
    <<~HELP
      Valid commands are:
        add "album" "artist"
        play "album"
        show all
        show unplayed
        show all by "artist"
        show unplayed by "artist"
        quit
    HELP
  end
end
