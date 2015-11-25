require 'rails_helper'

describe Tender do
  describe ".xls_to_params" do
  	it 'convert Spreadsheet row to Tender valid params' do
  		row = ['', '123', 'name', 'customer', nil, 'http://example.com',
  			'11.11.2015', '21.11.2015', '1000000', '20.11.2015', '22.11.2015', '20.11.2015']

  		params = Tender.xls_to_params(row)
  		tender = Tender.new(params)

  		expect(tender.valid?).to be_truthy
  		expect(tender.seldon_id).to eq 123
  		expect(tender.name).to eq 'name'
  		expect(tender.url).to eq 'http://example.com'
    end
  end

  describe ".to_csv" do
  	before :all do
  		create_list(:tender, 4)
  	end

  	it 'convert all tenders to .csv' do
  		csv = Tender.to_csv
  		tenders_count = Tender.count
  		first_tender  = Tender.first

  		expect(csv.lines.count).to eq tenders_count+1
  		expect(csv.lines[1]).to match(first_tender.seldon_id.to_s)
  		expect(csv.lines[1]).to match(first_tender.name)
  		expect(csv.lines[1]).to match(first_tender.url)
  	end
  end

  describe "#presale" do
  	before :all do
  		@tender = create(:tender)
  		@tender_with_presale    = create(:tender_with_presale)
  	end

    it 'returns special `presale` milestone if exist' do
      expect(@tender.presale).to eq nil
      expect(@tender_with_presale.presale).to be_a Milestone
    end
  end

  describe "#check_pre_sale" do
  	before :all do
  		@tender = create(:tender)
  	end

    it 'create special `presale` milestone if not already exist' do
    	@tender.check_pre_sale

    	expect(@tender.presale).to be_a Milestone
    end
  end
end


