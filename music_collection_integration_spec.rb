require_relative 'music_manager'
require_relative 'music_input'

RSpec.describe 'Music Input Full Integration' do
  let(:music_manager) { MusicManager.new }
  let(:music_input) { MusicInput.new(music_manager) }

  let(:commands) do
    [
      %(add "Ride the Lightning" "Metallica"),
      %(add "Licensed to Ill" "Beastie Boys"),
      %(add "Pauls Boutique" "Beastie Boys"),
      %(add "The Dark Side of the Moon" "Pink Floyd"),
      %(show all),
      %(play "Licensed to Ill"),
      %(play "The Dark Side of the Moon"),
      %(show all),
      %(show unplayed),
      %(show all by "Beastie Boys"),
      %(show unplayed by "Beastie Boys")
    ]
  end

  let(:output) do
    [
      %(Added "Ride the Lightning" by Metallica),
      %(Added "Licensed to Ill" by Beastie Boys),
      %(Added "Pauls Boutique" by Beastie Boys),
      %(Added "The Dark Side of the Moon" by Pink Floyd),
      %("Ride the Lightning" by Metallica (unplayed)
"Licensed to Ill" by Beastie Boys (unplayed)
"Pauls Boutique" by Beastie Boys (unplayed)
"The Dark Side of the Moon" by Pink Floyd (unplayed)),
      %(You're listening to "Licensed to Ill"),
      %(You're listening to "The Dark Side of the Moon"),
      %("Ride the Lightning" by Metallica (unplayed)
"Licensed to Ill" by Beastie Boys (played)
"Pauls Boutique" by Beastie Boys (unplayed)
"The Dark Side of the Moon" by Pink Floyd (played)),
      %("Ride the Lightning" by Metallica
"Pauls Boutique" by Beastie Boys),
      %("Licensed to Ill" by Beastie Boys (played)
"Pauls Boutique" by Beastie Boys (unplayed)),
      %("Pauls Boutique" by Beastie Boys)
    ]
  end

  it 'prints message when command is given' do
    commands.each do |command|
      expect(music_input.process_input(command)).to eq(output.shift)
    end
  end
end
