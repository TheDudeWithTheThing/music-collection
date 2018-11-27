# frozen_string_literal: true

require_relative 'music_viewer'

RSpec.describe MusicViewer do
  subject { described_class }
  let(:hide_played_status) { false }

  describe '#display' do
    context 'records is nil' do
      it 'returns "No Results"' do
        expect(subject.display(nil, hide_played_status)).to eq('No Results')
      end
    end

    context 'records is empty' do
      it 'returns "No Results"' do
        expect(subject.display([], hide_played_status)).to eq('No Results')
      end
    end

    context 'records has multiple records' do
      let(:records) do
        [
          { artist: 'Van Halen', album: '1984', played: true },
          { artist: 'Van Halen', album: 'Van Halen', played: false }
        ]
      end

      it 'returns correctly formatted string' do
        output = %("1984" by Van Halen (played)\n"Van Halen" by Van Halen (unplayed))

        expect(subject.display(records, hide_played_status)).to eq(output)
      end
    end

    context 'multiple records with hide display status true' do
      let(:hide_played_status) { true }
      let(:records) do
        [
          { artist: 'Van Halen', album: '1984', played: true },
          { artist: 'Van Halen', album: 'Van Halen', played: false }
        ]
      end

      it 'returns correctly formatted string' do
        output = %("1984" by Van Halen\n"Van Halen" by Van Halen)

        expect(subject.display(records, hide_played_status)).to eq(output)
      end
    end
  end
end
