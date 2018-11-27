# frozen_string_literal: true

class MusicViewer
  def self.display(records, hide_play_status)
    return 'No Results' if records.nil? || records.empty?

    records.map do |record|
      if hide_play_status
        format_record_without_played_status(record)
      else
        format_record_with_played_status(record)
      end
    end.join("\n")
  end

  def self.format_record_without_played_status(record)
    %("#{record[:album]}" by #{record[:artist]})
  end

  def self.format_record_with_played_status(record)
    format_record_without_played_status(record) + %( (#{played_unplayed(record[:played])}))
  end

  def self.played_unplayed(played)
    played ? 'played' : 'unplayed'
  end
end
