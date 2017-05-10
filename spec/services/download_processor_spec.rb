describe DownloadProcessor do
  let(:url) { 'https://www.youtube.com/watch?v=a4LVgdGN_8g' }
  let(:content) { create :content, url: url }
  let(:service) { DownloadProcessor.new content }
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

  context 'parse line filename', :focus do
    let(:line) { '[download] /Users/gingray/web/jessica_williams/yconv/public/content/a4LVgdGN_8g_Elon_Musk_gives_advice_to_entrepreneurs_04.04.2014_in_Russian.mp4 has already been downloaded' }
    let(:result) { service.parse_file_name line }
    it do
      expect(result).to eq '/Users/gingray/web/jessica_williams/yconv/public/content/a4LVgdGN_8g_Elon_Musk_gives_advice_to_entrepreneurs_04.04.2014_in_Russian.mp4'
    end
  end
end
