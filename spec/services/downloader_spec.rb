describe Downloader do
  let(:service) { Downloader.new url }

  context 'not url' do
    let(:url) { 'not url' }
    it do
      expect(service.valid?).to be_falsy
    end
  end

  context 'not supported host' do
    let(:url) { 'https://vimeo.com' }
    it do
      expect(service.valid?).to be_falsy
    end
  end

  context 'can not get valid name from url' do
    let(:url) { 'https://www.youtube.com/watch?X=a4LVgdGN_8g' }
    it do
      expect(service.valid?).to be_falsy
    end
  end

  context 'valid host' do
    let(:url) { 'https://www.youtube.com/watch?v=a4LVgdGN_8g' }
    it do
      expect(service.valid?).to be_truthy
    end
  end
end
