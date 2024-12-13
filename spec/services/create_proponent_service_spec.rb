# frozen_string_literal: true

require 'rails_helper'

# PARTICULARMENTE EU GOSTO DE SEGUIR O AAA para testes
# https://docs.telerik.com/devtools/justmock/basic-usage/arrange-act-assert
# então vc sempre vai faer uma separação clara da etapa

RSpec.describe CreateProponentService do
  subject(:service) do
    described_class.new(proponent_params, proponent_class: Proponent, inss_calculator_class: InssCalculatorService)
  end

  let(:proponent_params) do
    {
      name: 'John Doe',
      salary: 5000.0
    }
  end

  let(:proponent_class) { class_double(Proponent) }
  let(:proponent_instance) { instance_double(Proponent, salary: 5000.0, discount_inss: nil) }

  let(:inss_calculator_class) { class_double(InssCalculatorService) }

  describe '#execute' do
    context 'when creation is successful' do
      before do
        allow(Proponent).to receive(:new).with(proponent_params).and_return(proponent_instance)
        allow(inss_calculator_class).to receive(:call).with(5000.0).and_return(550.0)

        allow(proponent_instance).to receive(:discount_inss=).with(550.0)
        allow(proponent_instance).to receive(:save).and_return(true)
        allow(proponent_instance).to receive(:errors).and_return([])
      end

      it 'calculates the INSS discount and returns a success response' do
        service_with_mocks = described_class.new(proponent_params, proponent_class: Proponent,
                                                                   inss_calculator_class: inss_calculator_class)
        result = service_with_mocks.execute

        expect(inss_calculator_class).to have_received(:call).with(5000.0)
        expect(proponent_instance).to have_received(:discount_inss=).with(550.0)
        expect(result.success?).to be true
        expect(result.payload[:proponent]).to eq(proponent_instance)
        expect(result.errors).to be_empty
      end
    end

    context 'when creation fails' do
      before do
        allow(Proponent).to receive(:new).with(proponent_params).and_return(proponent_instance)
        allow(inss_calculator_class).to receive(:call).with(5000.0).and_return(550.0)

        allow(proponent_instance).to receive(:discount_inss=).with(550.0)
        allow(proponent_instance).to receive(:save).and_return(false)
        allow(proponent_instance).to receive(:errors).and_return(["Name can't be blank"])
      end

      it 'returns a failure response with errors' do
        service_with_mocks = described_class.new(proponent_params, proponent_class: Proponent,
                                                                   inss_calculator_class: inss_calculator_class)
        result = service_with_mocks.execute

        expect(inss_calculator_class).to have_received(:call).with(5000.0)
        expect(proponent_instance).to have_received(:discount_inss=).with(550.0)
        expect(result.success?).to be false
        expect(result.payload[:proponent]).to eq(proponent_instance)
        expect(result.errors).to eq(["Name can't be blank"])
      end
    end
  end
end
