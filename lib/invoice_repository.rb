require 'csv'
require 'time'
require_relative '../lib/invoice'
require_relative '../lib/repository'

class InvoiceRepository

  include Repository

  def initialize(invoices)
    @collection = invoices
  end

  def find_all_by_customer_id(id)
    all.find_all do |invoice|
      invoice.customer_id == id
    end
  end

  def find_all_by_merchant_id(id)
    all.find_all do |invoice|
      invoice.merchant_id == id
    end
  end

  def find_all_by_status(stat)
    all.find_all do |invoice|
      invoice.status == stat
    end
  end

  def create(attributes)
    new_invoice = Invoice.new({id: max_id + 1, 
                              customer_id: attributes[:customer_id],
                              merchant_id: attributes[:merchant_id], 
                              status: attributes[:status], 
                              created_at: Time.now.to_s,
                              updated_at: Time.now.to_s})
    @collection << new_invoice
    new_invoice
  end

  def update(id, attributes)
    if find_by_id(id)
      invoice = find_by_id(id)
      new_status = attributes[:status]
      invoice.status = new_status if attributes[:status]
      invoice.updated_at = Time.now
    end
  end
  
  def find_all_by_date(date)
    all.find_all do |invoice|
     Time.strptime(invoice.created_at.to_s, '%Y-%m-%d') == date
   end
  end

end
