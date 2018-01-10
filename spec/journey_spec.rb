require "journey"

describe Journey do
   subject(:journey) {described_class.new}
   let(:start_station) {double("station")}
  let(:exit_station) {double("station")}



   it "should initialize entry_station to nil" do
     expect(journey.entry_station).to be_nil
   end

   it "should initialize exit_station to nil" do
     expect(journey.exit_station).to be_nil
   end

   describe "#in_journey?" do
     it "should not be in journey" do
     expect(journey).to_not be_in_journey
     end

     it "should be in journey when journey started"do
       journey.start(start_station)
       expect(journey).to be_in_journey
     end

   end

   describe "#start" do
     it "should start a journey when called" do
     journey.start(start_station)
     expect(journey.entry_station).to eq start_station
     end
   end

   describe "#end" do
     it "should end a journey when called" do
     journey.end(exit_station)
     expect(journey.exit_station).to eq exit_station
     end
   end

   describe "#fare" do
     it "return mnimum fare" do
       journey.start(start_station)
       journey.end(exit_station)
     expect(journey.fare).to eq Journey::MINIMUM_CHARGE
     end

     it "return penalty fare, when you haven't touched in" do
      journey.end(exit_station)
     expect(journey.fare).to eq Journey::PENALTY_FARE
     end

     it "return penalty fare, when you haven't touched out" do
    journey.start(start_station)
     expect(journey.fare).to eq Journey::PENALTY_FARE
     end
   end
end
