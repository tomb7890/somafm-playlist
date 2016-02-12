# spec/spec_helper.rb
require 'webmock/rspec'
if 'test' == ENV['ENV']
  WebMock.disable_net_connect!(allow_localhost: true)
else
  WebMock.allow_net_connect!
end

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
    if 'test' == ENV['ENV']
      stub_request(:any, %r{http://somafm.com}).to_return do |request|
        response = local_html(request.uri)
        { body: response, status: 200 }
      end
    end
  end
end
