require 'rubygems'
require 'activeresource'
require 'prawn'

class Order < ActiveResource::Base
  
  STORE = 'YOUR_SHOPIFY_STORE_NAME'
  KEY = 'YOUR_SHOPIFY_KEY'
  PASS = 'YOUR_SHOPIFY_PASS'
  
  self.site = "https://#{KEY}:#{PASS}@#{STORE}.myshopify.com/admin"
  
end

Order.find(:all).each do |order|
  out = "order-#{order.id}.pdf"
  Prawn::Document.generate(out) do
    text "Order ID: #{order.id}"
    text "-" * 100
    
    text "Line Items:"
    order.line_items.each do |line_item|
      text "Product ID: #{line_item.id}"
      text "Name: #{line_item.name}"
      text "Price: #{line_item.price}"
    end
  end
  %x(open #{out})
end
