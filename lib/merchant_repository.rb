require 'csv'
require_relative '../lib/merchant'
require_relative '../lib/repository'

class MerchantRepository

    include Repository

    def initialize(merchants)
      @collection = merchants
    end

    def find_all_by_name(name)
      all.find_all do |merchant|
        merchant.name.upcase.include?(name.upcase)
      end
    end

    def create(attributes)
      new_id = max_id + 1
      name = attributes[:name]
      new_merchant = Merchant.new({name: name, id: new_id})
      @collection << new_merchant
      new_merchant
    end

    def update(id, attributes)
      if merchant = find_by_id(id)
        new_name = attributes[:name]
        merchant.name = new_name
      end
    end

end
