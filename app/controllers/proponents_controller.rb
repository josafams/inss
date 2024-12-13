# frozen_string_literal: true

class ProponentsController < ApplicationController
  def index
    @proponents = Proponent.page(params[:page])
  end

  def show
    @proponent = Proponent.find(params[:id])
  end

  def new
    @proponent = ProponentFactory.build
  end

  def edit
    @proponent = Proponent.find(params[:id])
  end

  def create
    @result_set = CreateProponentService.call(proponent_params)
    @proponent = @result_set.payload[:proponent]

    if @result_set.success?
      redirect_to @proponent, notice: 'Proponent criado com sucesso.'
    else
      render :new
    end
  end

  def update
    @result_set = UpdateProponentService.call(params[:id], proponent_params)
    @proponent = @result_set.payload[:proponent]

    if @result_set.success?
      redirect_to @proponent, notice: 'Proponent atualizado com sucesso.'
    else
      render :edit
    end
  end

  def calculate_inss
    salary = params[:salary].to_i
    discount_inss = InssCalculatorService.call(salary)
    render json: { discount_inss: discount_inss }
  end

  def group_calculate_inss
    render json: { payload: Proponent.by_discount_inss_count.as_json }
  end

  private

  def proponent_params
    params.require(:proponent).permit(:name, :document, :birthday, :salary,
                                      addresses_attributes: %i[id public_place number neighborhood city state zip_code _destroy],
                                      contacts_attributes: %i[id contact_type value _destroy])
  end
end
