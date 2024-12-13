# frozen_string_literal: true

class ProponentFactory
  def self.build
    @proponent = Proponent.new
    @proponent.addresses.build
    @proponent.contacts.build
    @proponent
  end
end
