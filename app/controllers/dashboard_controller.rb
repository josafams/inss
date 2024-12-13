# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @groups_calculate_inss = Proponent.by_discount_inss_count
  end
end
