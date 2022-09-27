require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    before do
      @category = Category.new(:name => 'trees').save
      @product = Product.new
      @product.name = 'cedar'
      @product.price_cents = 300
      @product.quantity = 15
      @product.category = Category.where(:name == 'trees')[0]
    end
    it "will save properly" do
      @product.save
      expect(Product.where(:name == 'cedar')[0]).to eq @product
    end
    it "will not save without name" do
      @product.name = nil
      @product.save
      expect(@product.errors.full_messages).to include "Name can't be blank"
    end
    it "will not save without price" do
      @product.price_cents = nil
      @product.save
      expect(@product.errors.full_messages).to include "Price can't be blank"
    end
    it "will not save without quantity" do
      @product.quantity = nil
      @product.save
      expect(@product.errors.full_messages).to include "Quantity can't be blank"
    end
    it "will not save without category" do
      @product.category = nil
      @product.save
      expect(@product.errors.full_messages).to include "Category must exist", "Category can't be blank" 
    end
  end
end