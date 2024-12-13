# frozen_string_literal: true

class ExportCsvService
    include Callable
    
    def self.execute(*args)
        # processsamento pesado e envio do arquivo
        puts 'executando algo'
    end
end