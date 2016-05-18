# spec/spec_helper.rb
require 'Rake'
require 'webmock/rspec'

def this_is_a_spec_task
  # if Rake::Task.tasks.include?('spec')
  true
end

if this_is_a_spec_task
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
    if this_is_a_spec_task
      stub_request(:any, %r{http://somafm.com}).to_return do |request|
        response = local_html(request.uri)
        { body: response, status: 200 }
      end
    end
  end
end
