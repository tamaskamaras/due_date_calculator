require 'date'

class DueDateCalculator

  attr_reader :submitted_at, :turnaround_time

  def initialize(options = {})
    @submitted_at = normalized_date_from(options[:submitted_at])
    @turnaround_time = options[:turnaround_time].to_i
  end

  private

  def normalized_date_from(input)
    # TODO
  end
end
