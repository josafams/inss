# frozen_string_literal: true

class ExportCsvService
  include Callable

  def self.execute(*_args)
    # processsamento pesado e envio do arquivo
    Rails.logger.debug 'executando algo'
  end
end
