require 'rails_helper'

describe CarDealership do
  describe "#deliver_car" do

    let(:toyota_dealer) {CarDealership.new}
    context "failure" do
     it "does not deliver a car with the year less than 2000" do
        delivery = toyota_dealer.deliver_car(1990, 'Venza', 'red', 'Austin')
        expect(delivery.success).to eq nil
        expect(delivery.failure).to eq 'We have no cars manufactured in year 1990'
     end

     it "does not deliver an unavailable model" do
      delivery = toyota_dealer.deliver_car(2005, 'Rav4', 'red', 'Austin')
      expect(delivery.success).to eq nil
      expect(delivery.failure).to eq 'The model requested is unavailable'
     end

     it "does not deliver an unavailable color" do
      delivery = toyota_dealer.deliver_car(2015, 'Venza', 'yellow', 'Austin')
      expect(delivery.success).to eq nil
      expect(delivery.failure).to eq 'Color yellow is unavailable'
     end

     it "does not deliver to a city not nearby" do
      delivery = toyota_dealer.deliver_car(2000, 'Venza', 'red', 'Surrey')
      expect(delivery.success).to eq nil
      expect(delivery.failure).to eq 'Apologies, we cannot deliver to this city'
     end
    end
    context "success" do
     it "delivers a car when all conditions are met" do
      delivery = toyota_dealer.deliver_car(2000, 'Avalon', 'blue', 'Austin')
      expect(delivery.success).to eq 'A blue 2000 Toyota Avalon will be delivered to Austin'
      expect(delivery.failure).to eq nil
     end
    end
  end
end