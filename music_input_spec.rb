# frozen_string_literal: true

require_relative 'music_input'

RSpec.describe MusicInput do
  let(:manager) { double(MusicManager) }
  subject { described_class.new(manager) }

  describe '.process_input' do
    context 'input is a valid add command' do
      let(:input) { 'add "Album" "Artist"' }

      it 'calls process_add' do
        expect(subject).to receive(:process_add).with(input)

        subject.process_input(input)
      end
    end

    context 'input is a valid play command' do
      let(:input) { 'play "Album"' }

      it 'calls process_play' do
        expect(subject).to receive(:process_play).with(input)

        subject.process_input(input)
      end
    end

    context 'input is a valid show all command' do
      let(:input) { 'show all' }

      it 'calls process_show' do
        expect(subject).to receive(:process_show).with(input)

        subject.process_input(input)
      end
    end

    context 'input is a valid show unplayed command' do
      let(:input) { 'show unplayed' }

      it 'calls process_show' do
        expect(subject).to receive(:process_show).with(input)

        subject.process_input(input)
      end
    end

    context 'input is not valid' do
      let(:input) { 'invalid command' }

      it 'prints help' do
        expect(subject).to receive(:print_help)

        subject.process_input(input)
      end
    end
  end

  describe '.process_show' do
    context 'show all' do
      let(:input) { 'show all' }

      it 'calls select_all on manager' do
        expect(manager).to receive(:select_all).with(false)

        subject.process_show(input)
      end
    end

    context 'show unplayed' do
      let(:input) { 'show unplayed' }

      it 'calls select_all on manager with unplayed true' do
        expect(manager).to receive(:select_all).with(true)

        subject.process_show(input)
      end
    end

    context 'show all by "Artist"' do
      let(:input) { 'show all by "Artist"' }

      it 'calls select_all on manager with "Artist" and unplayed false' do
        expect(manager).to receive(:select_by_artist).with('Artist', false)

        subject.process_show(input)
      end
    end

    context 'show all by "Artist"' do
      let(:input) { 'show all by "Artist"' }

      it 'calls select_all on manager with "Artist" and unplayed false' do
        expect(manager).to receive(:select_by_artist).with('Artist', false)

        subject.process_show(input)
      end
    end
  end

  describe '.process_add' do
    context 'input has artist and ablum' do
      let(:input) { 'add "Van Halen II" "Van Halen"' }

      it 'class manager.add with Artist and Album' do
        expect(manager).to receive(:add).with('Van Halen', 'Van Halen II')

        subject.process_add(input)
      end
    end

    context 'input is missing album' do
      let(:input) { 'add "Van Halen"' }

      it 'prints help' do
        expect(subject).to receive(:print_help)

        subject.process_add(input)
      end
    end
  end

  describe '.process_play' do
    context 'invalid input' do
      let(:input) { 'play AAAAA' }

      it 'prints help' do
        expect(subject).to receive(:print_help)

        subject.process_play(input)
      end
    end

    context 'album is in collection' do
      let(:input) { 'play "A"' }

      it 'says album is playing' do
        expect(manager).to receive(:play).with('A') { true }
        expect(subject.process_play(input)).to eq('You\'re listening to "A"')
      end
    end

    context 'album is not in collection' do
      let(:input) { 'play "A"' }

      it 'says album does not exist' do
        expect(manager).to receive(:play).with('A') { false }
        expect(subject.process_play(input)).to eq('Album A does not exist')
      end
    end
  end

  describe '.pretty_puts' do
    context 'records is nil' do
      it 'returns "No Results"' do
        expect(subject.pretty_puts(nil)).to eq('No Results')
      end
    end

    context 'records is empty' do
      it 'returns "No Results"' do
        expect(subject.pretty_puts([])).to eq('No Results')
      end
    end

    context 'records has multiple' do
      let(:records) do
        [
          { artist: 'Van Halen', album: '1984', played: true },
          { artist: 'Van Halen', album: 'Van Halen', played: false }
        ]
      end

      it 'returns correctly formatted string' do
        output = %{"1984" by Van Halen (played)\n"Van Halen" by Van Halen (unplayed)}
        expect(subject.pretty_puts(records)).to eq(output)
      end
    end
  end
end
