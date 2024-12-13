# frozen_string_literal: true

class CreateProponentService
  include Callable

  def initialize(proponent_params, proponent_class: Proponent, inss_calculator_class: InssCalculatorService)
    @proponent = proponent_class.new(proponent_params)
    @inss_calculator_service = inss_calculator_class
  end

  def execute
    @proponent.discount_inss = @inss_calculator_service.call(@proponent.salary)

    return OpenStruct.new({ success?: true, payload: { proponent: @proponent }, errors: [] }) if @proponent.save

    OpenStruct.new({ success?: false, payload: { proponent: @proponent }, errors: @proponent.errors })
  end
end
