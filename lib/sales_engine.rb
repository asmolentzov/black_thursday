require 'csv'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/invoice_item_repo'
require_relative './sales_analyst'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :transactions,
              :customers,
              :invoice_items,
              :analyst

  def initialize(items, merchants, invoices, transactions, customers, invoice_items)
    @items = ItemRepository.new(items)
    @merchants = MerchantRepository.new(merchants)
    @invoices = InvoiceRepository.new(invoices)
    @transactions = TransactionRepository.new(transactions)
    @customers = CustomerRepository.new(customers)
    @invoice_items = InvoiceItemRepository.new(invoice_items)
    @analyst = SalesAnalyst.new(self)
  end

  def self.from_csv(info)
    items = self.populate_items(info[:items])
    merchants = self.populate_merchants(info[:merchants])
    invoices = self.populate_invoices(info[:invoices])
    transactions = self.populate_transactions(info[:transactions])
    customers = self.populate_customers(info[:customers])
    invoice_items = self.populate_invoice_items(info[:invoice_items])
    self.new(items, merchants, invoices, transactions, customers, invoice_items)
  end

  def self.populate_invoices(file_path)
    if file_path
      file = CSV.read(file_path, headers: true, header_converters: :symbol)
      file.map do |row|
        Invoice.new(row)
      end
    end
  end

  def self.populate_merchants(file_path)
    if file_path
      file = CSV.read(file_path, headers: true, header_converters: :symbol )
      file.map do |row|
        Merchant.new(row)
      end
    end
  end

  def self.populate_items(file_path)
    if file_path
      file = CSV.read(file_path, headers: true, header_converters: :symbol )
      file.map do |row|
        Item.new(row)
      end
    end
  end

  def self.populate_invoice_items(file_path)
    if file_path
      file = CSV.read(file_path, headers: true, header_converters: :symbol)
      file.map do |row|
       InvoiceItem.new(row)
      end
    end
  end

  def self.populate_transactions(file_path)
    if file_path
      file = CSV.read(file_path, headers: true, header_converters: :symbol )
      file.map do |row|
        Transaction.new(row)
      end
    end
  end

  def self.populate_customers(file_path)
    if file_path
      file = CSV.read(file_path, headers: true, header_converters: :symbol )
      file.map do |row|
        Customer.new(row)
      end
    end
  end

end
