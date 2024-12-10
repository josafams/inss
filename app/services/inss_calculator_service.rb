# frozen_string_literal: true

class InssCalculator
  # 1st range: Up to 1,412.00 - 7.5%
  # 2nd range: 1,412.01 to 2,666.68 - 9%
  # 3rd range: 2,666.69 to 4,000.03 - 12%
  # 4th range: 4,000.04 to 7,786.02 - 14%

  RANGES = [
    { limit: 1412.00, rate: 0.075 },
    { limit: 2666.68, rate: 0.09 },
    { limit: 4000.03, rate: 0.12 },
    { limit: 7786.02, rate: 0.14 }
  ].freeze

  def self.call(salary)
    return 0 if salary <= 0

    total = 0
    previous = 0

    RANGES.each do |range|
      if salary > range[:limit]
        calculation_base = range[:limit] - previous
        total += calculation_base * range[:rate]
        previous = range[:limit]
      else
        calculation_base = salary - previous
        total += calculation_base * range[:rate]
        break
      end
    end

    total.round(2)
  end
end
