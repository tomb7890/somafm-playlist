require_relative '../somafm'

describe 'Groove Salad Link' do
  it 'detects a bad URI' do
    baduri = '##$$%%'
    expect { URI.parse(baduri) }.to raise_error(URI::InvalidURIError)
  end

  it 'returns a valid URI' do
    s = SomafmPlaylist.new
    expect { URI.parse(s.groove_salad_uri) }.not_to raise_error
  end

  it 'finds secretagent in results set ' do
    s = SomafmPlaylist.new
    set = s.set
    expect(set).to include('secretagent')
  end
end
