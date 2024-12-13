# frozen_string_literal: true

class Contact < ApplicationRecord
  belongs_to :proponent

  enum contact_type: { telefone_residencial: 0, celular: 1, whatsapp: 2, email: 3 }
end
