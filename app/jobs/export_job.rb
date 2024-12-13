class ExportJob < ApplicationJob
  queue_as :export_csv

  def perform(*args)
    # Não gosto de colocar regra de negocio em Jobs
    # normalmente ele é apenas um proxy para serviços
    ExportCsvService.execute(*args)
  end
end
