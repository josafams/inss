# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @groups_calculate_inss = Proponent.by_discount_inss_count
  end

  def export_csv
    ExportJob.perform_later(filters, current_user)

    redirect_to root_path, notice: 'Gerando relátorio, cheque seu email'
  end

  private

  def filters
    {} # sanatização em params e etc.
  end
end
