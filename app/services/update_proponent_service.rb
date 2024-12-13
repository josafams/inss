# frozen_string_literal: true

class UpdateProponentService
  include Callable

  attr_reader :proponent_params

  def initialize(id, proponent_params, proponent_class: Proponent, inss_calculator_class: InssCalculatorService)
    @proponent = proponent_class.find(id)
    @inss_calculator_service = inss_calculator_class
    @proponent_params = proponent_params
  end

  def execute
    @proponent.assign_attributes(proponent_params)

    @proponent.discount_inss = @inss_calculator_service.call(@proponent.salary)

    return OpenStruct.new({ success?: true, payload: @proponent, errors: [] }) if @proponent.save

    OpenStruct.new({ success?: false, payload: @proponent, errors: @proponent.errors })
  end
end
