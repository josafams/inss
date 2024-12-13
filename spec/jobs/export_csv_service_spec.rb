require 'rails_helper'

# Teste para jobs normalmente deve ser apenas checagem se ele executou 
# os services corretos com parametros certos.

describe ExportJob, type: :job do
  let(:args) { ['param1', 'param2', 'param3'] }

  it 'calls ExportCsvService with the correct arguments' do
    allow(ExportCsvService).to receive(:execute)

    described_class.perform_now(*args)

    expect(ExportCsvService).to have_received(:execute).with(*args)
  end
end
