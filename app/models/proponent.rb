# frozen_string_literal: true

class Proponent < ApplicationRecord
  scope :by_discount_inss_count, lambda {
    select('discount_inss, COUNT(*) AS count')
      .group('discount_inss')
  }

  MAX_PROPONENT_PER_PAGE = 5

  paginates_per MAX_PROPONENT_PER_PAGE

  # Dependendo da criticidade da informação o mais correto seria usar uma gem like paranoia
  # https://github.com/rubysherpas/paranoia
  # para que não possivel excluir registro do banco.

  has_many :addresses, dependent: :destroy
  has_many :contacts, dependent: :destroy

  accepts_nested_attributes_for :addresses, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :contacts, reject_if: :all_blank, allow_destroy: true

  validates :name, :document, :birthday, :salary, presence: true
end
