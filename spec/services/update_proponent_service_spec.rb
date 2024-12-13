# frozen_string_literal: true

require 'rails_helper'
require 'ostruct' # If not already required globally.

RSpec.describe UpdateProponentService do
  subject(:service) do
    described_class.new(id, proponent_params, proponent_class: Proponent, inss_calculator_class: InssCalculatorService)
  end

  let(:id) { 123 }
  let(:proponent_params) do
    {
      name: 'Jane Doe',
      salary: 6000.0
    }
  end

  let(:proponent_class) { class_double(Proponent) }
  let(:proponent_instance) { instance_double(Proponent, salary: 6000.0, discount_inss: nil) }
  let(:inss_calculator_class) { class_double(InssCalculatorService) }

  describe '#execute' do
    context 'when update is successful' do
      before do
        allow(Proponent).to receive(:find).with(id).and_return(proponent_instance)
        allow(inss_calculator_class).to receive(:call).with(6000.0).and_return(660.0)

        allow(proponent_instance).to receive(:assign_attributes).with(proponent_params)
        allow(proponent_instance).to receive(:discount_inss=).with(660.0)
        allow(proponent_instance).to receive(:save).and_return(true)
        allow(proponent_instance).to receive(:errors).and_return([])
      end

      it 'assigns attributes, calculates INSS, saves successfully and returns success' do
        service_with_mocks = described_class.new(id, proponent_params, proponent_class: Proponent,
                                                                       inss_calculator_class: inss_calculator_class)
        result = service_with_mocks.execute

        expect(Proponent).to have_received(:find).with(id)
        expect(inss_calculator_class).to have_received(:call).with(6000.0)
        expect(proponent_instance).to have_received(:assign_attributes).with(proponent_params)
        expect(proponent_instance).to have_received(:discount_inss=).with(660.0)
        expect(proponent_instance).to have_received(:save)

        expect(result.success?).to be true
        expect(result.payload[:proponent]).to eq(proponent_instance)
        expect(result.errors).to be_empty
      end
    end

    context 'when update fails' do
      before do
        allow(Proponent).to receive(:find).with(id).and_return(proponent_instance)
        allow(inss_calculator_class).to receive(:call).with(6000.0).and_return(660.0)

        allow(proponent_instance).to receive(:assign_attributes).with(proponent_params)
        allow(proponent_instance).to receive(:discount_inss=).with(660.0)
        allow(proponent_instance).to receive(:save).and_return(false)
        allow(proponent_instance).to receive(:errors).and_return(["Name can't be blank"])
      end

      it 'returns a failure response with errors' do
        service_with_mocks = described_class.new(id, proponent_params, proponent_class: Proponent,
                                                                       inss_calculator_class: inss_calculator_class)
        result = service_with_mocks.execute

        expect(Proponent).to have_received(:find).with(id)
        expect(inss_calculator_class).to have_received(:call).with(6000.0)
        expect(proponent_instance).to have_received(:assign_attributes).with(proponent_params)
        expect(proponent_instance).to have_received(:discount_inss=).with(660.0)
        expect(proponent_instance).to have_received(:save)

        expect(result.success?).to be false
        expect(result.payload[:proponent]).to eq(proponent_instance)
        expect(result.errors).to eq(["Name can't be blank"])
      end
    end
  end
end
