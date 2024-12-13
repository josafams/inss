# frozen_string_literal: true

require 'rails_helper'

# Teste para jobs normalmente deve ser apenas checagem se ele executou
# os services corretos com parametros certos.

describe ExportJob do
  let(:args) { %w[param1 param2 param3] }

  it 'calls ExportCsvService with the correct arguments' do
    allow(ExportCsvService).to receive(:execute)

    described_class.perform_now(*args)

    expect(ExportCsvService).to have_received(:execute).with(*args)
  end
end
