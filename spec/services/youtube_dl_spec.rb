describe YoutubeDl do
  let(:url) { 'https://www.youtube.com/watch?v=a4LVgdGN_8g' }
  let(:service) { YoutubeDl.new url }
  let(:content) { Content.first }

  context 'create content model' do
    before { service.content }
    it do
      expect(content).to be_present
      expect(content.name).to eq 'a4LVgdGN_8g'
    end
  end

  context 'parse line progress' do
    let(:line) { '[download] 60.8% of 26.33MiB at  5.24MiB/s ETA 00:00' }
    before { service.parse_line line }
    it do
      expect(content.progress).to eq 60.8
    end
  end

  context 'parse line description', :focus do
    let(:line) { '[download] Destination: NaVi vs Secret _ DreamLeague Season 7-zEWzdYLw6iY.mp4' }
    before { service.parse_line line }
    it do
      expect(content.progress).to eq 60.8
    end
  end
end
