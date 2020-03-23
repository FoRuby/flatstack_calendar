module EventHelper
  def format(event, field)
    @event = event
    send field
  end

  private

  def start_end
    start_date = @event.date.to_formatted_s(:rfc822)
    end_date = (@event.date + @event.duration).to_formatted_s(:rfc822)
    "#{start_date} — #{end_date}"
  end

  def duration
    "Event duration: #{@event.duration} #{'day'.pluralize(@event.duration)}"
  end

  def author
    "Author: #{@event.user.name}"
  end
end
