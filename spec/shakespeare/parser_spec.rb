RSpec.describe Shakespeare::Parser do

  subject = described_class.new
  let(:character_array) { subject.character_array }
  let(:lines_per_character) { subject.lines_per_character(character_array) }

  before(:each) do
    allow_any_instance_of(Shakespeare::Parser).to receive(:source_url).and_return('fixtures/macbeth.xml')
  end

  context "nokogiri successfully parses the file" do
    it 'populates an array of character names' do
      expect(subject.character_array).to be_instance_of(Array)
    end
  end

  context "We are able to determine lines per character" do
    it 'returns a hash of character information' do
      expect(lines_per_character).to be_instance_of(Hash)
    end

    it 'normalizes the names' do
      expect(lines_per_character).to include('Macbeth')
    end
  end

  context "hash formatting" do
    let(:example_data) { {"Macbeth"=>5868, "Lady macbeth"=>2069, "Malcolm"=>1612, "Macduff"=>1266, "Ross"=>996, "Banquo"=>850, "Lennox"=>551, "Duncan"=>496, "First witch"=>406, "Porter"=>360, "Doctor"=>355, "Lady macduff"=>324,
                          "Hecate"=>282, "Sergeant"=>248, "Siward"=>219, "Gentlewoman"=>202, "Messenger"=>193, "First murderer"=>182, "Lord"=>160, "Son"=>159, "Third witch"=>148, "Angus"=>140, "Second witch"=>139, "Old man"=>89, "Second murderer"=>86, "Caithness"=>78, "Donalbain"=>74, "Menteith"=>70, "Third murderer"=>47,
                          "Young siward"=>46, "Seyton"=>39, "Third apparition"=>34, "Second apparition"=>27, "Servant"=>25, "Fleance"=>20, "First apparition"=>18, "Lords"=>15, "Attendant"=>10, "Both murderers"=>10, "Soldiers"=>4} }

    it 'returns correct keys' do
      expect(lines_per_character).to have_key('Malcolm')
    end

    it 'has no nil values' do
      expect(lines_per_character).to_not include(nil)
    end

    it 'matches the example data' do
      expect(lines_per_character).to eq(example_data)
    end

  end
end
