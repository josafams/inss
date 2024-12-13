# frozen_string_literal: true

class Contact < ApplicationRecord
  belongs_to :proponent

  enum contact_type: { telefone_residencial: 'telefone_residencial', celular: 'celular', whatsapp: 'celular', email: 'email' }
end
