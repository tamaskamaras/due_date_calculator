require 'time'

class DueDateCalculator

  attr_reader :submitted_at, :turnaround_time, :work_start, :work_end, :start, :finish

  def initialize(options = {})
    raise ArgumentError, 'turnaround_time is missing' unless options[:turnaround_time]

    @submitted_at    = options[:submitted_at] || Time.now
    @turnaround_time = options[:turnaround_time].to_f
    @work_start      = options[:work_start] || 9
    @work_end        = options[:work_end] || 17
    @start           = coerced_into_working_hours(time_from(submitted_at))
  end

  def execute
    ret            = start
    remaining_time = hours(turnaround_time)

    while remaining_time > 0 do
      if remaining_time >= hours(8)
        ret += hours(8)
        remaining_time -= hours(8)
        ret += nighttime unless ret == work_end_on(ret)
      else
        ret += nighttime if seconds_until_end_of_workday(ret) < remaining_time
        ret += remaining_time
        remaining_time = 0
      end
      ret = add_weekend_if_needed(ret)
    end

    @finish = ret
  end
  alias :run :execute

  private

  def hours(n)
    n * 3600
  end
  alias :hour :hours

  def days(n)
    n * hours(24)
  end
  alias :day :days

  def nighttime
    (24 - (work_end - work_start)) * 3600
  end

  def seconds_until_end_of_workday(basetime)
    work_end_on(basetime) - basetime
  end

  def time_from(input)
    input.is_a?(String) ? Time.parse(input) : input.to_time
  end

  def work_start_on(t)
    Time.new(t.year, t.month, t.day, work_start)
  end

  def work_end_on(t)
    Time.new(t.year, t.month, t.day, work_end)
  end

  def coerced_into_working_hours(input_time)
    if input_time > work_end_on(input_time)
      ret = input_time + day(1)
      ret = Time.new(ret.year, ret.month, ret.day, work_start)
    elsif input_time < work_start_on(input_time)
      ret = work_start_on(input_time)
    else
      ret = input_time
    end

    add_weekend_if_needed(ret)
  end

  def add_weekend_if_needed(input_time)
    case input_time.strftime('%A')
    when 'Saturday'
      input_time + days(2)
    when 'Sunday'
      input_time + day(1)
    else
      input_time
    end
  end
end
