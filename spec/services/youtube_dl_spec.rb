describe YoutubeDl do
  let(:url) { 'https://www.youtube.com/watch?v=a4LVgdGN_8g' }
  let(:service) { YoutubeDl.new url }

  context 'create content model', :focus do
    let(:content) { Content.first }
    before { service.content }
    it do
      expect(content).to be_present
      expect(content.name).to eq 'a4LVgdGN_8g'
    end
  end

  context 'parse line' do
    let(:line) { '[download] 60.8% of 26.33MiB at  5.24MiB/s ETA 00:00' }
    it do
      expect(1).to eq 2
    end
  end
end
