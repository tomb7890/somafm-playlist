require 'webmock/rspec'

def local_html(f)
  localfile = if f.to_s == 'http://somafm.com:80/'
                'spec/data/somafm.com/index.html'
              else
                "spec/data/somafm.com#{f.path}"
              end
  File.open(localfile, 'r')
end

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:any, %r{http://somafm.com}).to_return do |request|
      response = local_html(request.uri)
      { body: response, status: 200 }
    end
  end
end
