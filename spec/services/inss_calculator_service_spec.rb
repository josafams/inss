# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InssCalculatorService do
  describe '.call' do
    context 'when salary is zero or negative' do
      it 'returns 0 for zero salary' do
        expect(described_class.call(0)).to eq(0)
      end

      it 'returns 0 for a negative salary' do
        expect(described_class.call(-1000)).to eq(0)
      end
    end

    context 'when salary is within the first range 7.5%' do
      it 'calculates correctly for salary less than the first range limit' do
        salary = 1000.00
        expected = (1000.00 * 0.075).round(2)
        expect(described_class.call(salary)).to eq(expected)
      end

      it 'calculates correctly at the exact first range limit' do
        salary = 1412.00
        expected = (1412.00 * 0.075).round(2)
        expect(described_class.call(salary)).to eq(expected)
      end
    end

    context 'when salary is within the second range 9%' do
      it 'calculates correctly for a salary in the second range' do
        salary = 2000.00
        first_range = 1412.00 * 0.075
        second_range = (2000.00 - 1412.00) * 0.09
        expected = (first_range + second_range).round(2)
        expect(described_class.call(salary)).to eq(expected)
      end

      it 'calculates correctly at the top limit of the second range' do
        salary = 2666.68
        first_range = 1412.00 * 0.075
        second_range = (2666.68 - 1412.00) * 0.09
        expected = (first_range + second_range).round(2)
        expect(described_class.call(salary)).to eq(expected)
      end
    end

    context 'when salary is within the third range 12%' do
      it 'calculates correctly for a salary in the third range' do
        salary = 3000.00
        first_range = 1412.00 * 0.075
        second_range = (2666.68 - 1412.00) * 0.09
        third_range = (3000.00 - 2666.68) * 0.12
        expected = (first_range + second_range + third_range).round(2)
        expect(described_class.call(salary)).to eq(expected)
      end

      it 'calculates correctly at the top limit of the third range' do
        salary = 4000.03
        first_range = 1412.00 * 0.075
        second_range = (2666.68 - 1412.00) * 0.09
        third_range = (4000.03 - 2666.68) * 0.12
        expected = (first_range + second_range + third_range).round(2)
        expect(described_class.call(salary)).to eq(expected)
      end
    end

    context 'when salary is within the fourth range 14%' do
      it 'calculates correctly for a salary in the fourth range' do
        salary = 5000.00
        first_range = 1412.00 * 0.075
        second_range = (2666.68 - 1412.00) * 0.09
        third_range = (4000.03 - 2666.68) * 0.12
        fourth_range = (5000.00 - 4000.03) * 0.14
        expected = (first_range + second_range + third_range + fourth_range).round(2)
        expect(described_class.call(salary)).to eq(expected)
      end

      it 'calculates correctly at the top limit of the fourth range' do
        salary = 7786.02
        first_range = 1412.00 * 0.075
        second_range = (2666.68 - 1412.00) * 0.09
        third_range = (4000.03 - 2666.68) * 0.12
        fourth_range = (7786.02 - 4000.03) * 0.14
        expected = (first_range + second_range + third_range + fourth_range).round(2)
        expect(described_class.call(salary)).to eq(expected)
      end
    end

    context 'when salary exceeds the highest range limit' do
      it 'calculates using the top range limit for a salary above the last range' do
        salary = 10_000.00
        first_range = 1412.00 * 0.075
        second_range = (2666.68 - 1412.00) * 0.09
        third_range = (4000.03 - 2666.68) * 0.12
        fourth_range = (7786.02 - 4000.03) * 0.14
        expected = (first_range + second_range + third_range + fourth_range).round(2)
        expect(described_class.call(salary)).to eq(expected)
      end
    end
  end
end
