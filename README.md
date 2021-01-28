# Due Date Calculator

Library for calculating deadlines/due dates with working days and working hours taken into consideration.

## Getting Started

Install through command prompt

```
gem install due_date_calculator --source https://github.com/tamaskamaras/due_date_calculator.git
```

Or include in your Gemfile

```
gem 'due_date_calculator', git: 'https://github.com/tamaskamaras/due_date_calculator.git'
```

## Usage

```
calculator = DueDateCalculator.new(submitted_at: Time.now, turnaround_time: 17)
calculator.run => 2021-02-02 10:00:00 +0100
```

Where `submitted_at` is the submit time and `turnaround_time` is the amount of time refering to the working hours that can be spent on the issue. The return value is the Time type deadline until the task has to be finished.

The result is considering only 8 working hours every workingday (default: 9:00-17:00), so evenings, weekends are skiped hence the `turnaround_time` hours are distributed into actual working hours.

The start and the end of the working day can be set explicitly:
```
calculator = DueDateCalculator.new(
  submitted_at: Time.now,
  turnaround_time: 16,
  work_start: 8,
  work_end: 16
)
calculator.run => 2021-02-02 09:00:00 +0100
```
In that case the working day can be shorter or longer then 8 hours.

## Contribution

**Due Date Calculator** was created and maintained by [tamaskamaras](https://github.com/tamaskamaras)

Contributions are welcomed in the form of

* forking the project
* create a feature branch

## License

Due Date Calculator was released under the [MIT License](https://opensource.org/licenses/MIT).

