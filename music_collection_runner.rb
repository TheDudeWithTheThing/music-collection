# frozen_string_literal: true

class MusicCollectionRunner
  attr_reader :music_input

  PROMPT = '> '

  def initialize(music_input)
    @music_input = music_input
  end

  def run
    intro

    accept_input

    outro
  end

  def accept_input
    input = ''

    while input != 'quit'
      print PROMPT
      input = read_input

      puts music_input.process_input(input) unless input == 'quit'

      puts
    end
  end

  def read_input
    STDIN.gets.chomp
  end

  def intro
    puts
    puts 'Welcome to your music collection!'
    puts
  end

  def outro
    puts 'Bye!'
    puts
  end
end
