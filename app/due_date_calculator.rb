require 'date'

class DueDateCalculator

  attr_reader :submitted_at, :turnaround_time

  def initialize(options = {})
    @submitted_at = normalized_date_from(options[:submitted_at])
    @turnaround_time = options[:turnaround_time].to_i
  end

  def execute
    # TODO
  end
  alias :run :execute

  private

  def normalized_date_from(input)
    return DateTime.now unless input

    input.is_a?(String) ? DateTime.strptime(input, '%Y-%M-%d') : input.to_datetime
  end
end
