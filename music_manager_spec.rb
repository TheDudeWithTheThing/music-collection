# frozen_string_literal: true

require_relative './music_manager'

RSpec.describe MusicManager do
  let(:artist) { 'Van Halen' }
  let(:album) { '1984' }

  before do
    subject.add(artist, album)
  end

  describe '.add' do
    it 'adds artist to artist array' do
      expect(subject.artists.include?(artist)).to eq(true)
    end

    it 'adds album to album array' do
      expect(subject.albums.include?(album)).to eq(true)
    end

    it 'adds album to unplayed set' do
      expect(subject.unplayed.include?(0)).to eq(true)
    end

    it 'does not add album to played set' do
      expect(subject.played.include?(0)).to eq(false)
    end

    context 'album has already been added' do
      it 'does not allow duplicates' do
        expect(subject.add(artist, album)).to eq(false)
        expect(subject.albums.size).to eq(1)
        expect(subject.artists.size).to eq(1)
      end
    end
  end

  describe '.play' do
    context 'album has already been played' do
      before do
        subject.play(album)
      end

      it 'returns true' do
        expect(subject.play(album)).to eq(true)
      end
    end

    context 'album is unplayed' do
      it 'returns true' do
        expect(subject.play(album)).to eq(true)
      end

      it 'removes from unplayed' do
        subject.play(album)
        expect(subject.unplayed.include?(0)).to eq(false)
      end

      it 'adds to played' do
        subject.play(album)
        expect(subject.played.include?(0)).to eq(true)
      end
    end

    context 'album has not been added to collection' do
      it 'returns false' do
        expect(subject.play('Van Halen II')).to eq(false)
      end
    end
  end

  describe '.select_by_artist' do
    context 'Artist has 1 album in collection' do
      it 'returns serialized data' do
        result = subject.select_by_artist(artist, false)
        expect(result).to eq([{ artist: artist, album: album, played: false }])
      end
    end

    context 'Artist is not in collection' do
      it 'returns empty array' do
        result = subject.select_by_artist('Radiohead', false)
        expect(result).to eq([])
      end
    end

    context 'Artist has many albums in collection' do
      before do
        subject.add(artist, 'Van Halen')
        subject.add(artist, 'Van Halen II')
        subject.add(artist, 'Van Halen III')
      end

      context 'unplayed is true' do
        it 'returns unplayed serialized data' do
          subject.play('Van Halen II')
          subject.play('Van Halen III')

          result = subject.select_by_artist(artist, true)
          expect(result).to eq([{ artist: artist, album: album, played: false }, { artist: artist, album: 'Van Halen', played: false }])
        end
      end
    end
  end

  describe 'select_all' do
    context 'only 1 artist and 1 album in collection' do
      it 'returns serialized data' do
        result = subject.select_all(true)
        expect(result).to eq([{ artist: artist, album: album, played: false }])
      end

      context 'album is played' do
        it 'returns empty array' do
          subject.play(album)
          result = subject.select_all(true)
          expect(result).to eq([])
        end
      end
    end
  end
end
