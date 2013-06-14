require 'bundler/setup'
require 'sinatra/base'
require 'rack/rewrite'

# The project root directory
$root = ::File.dirname(__FILE__)

use Rack::Rewrite do
  r301 %r{/tag/(.*)}, '/category/$1'
  r301 %r{.*}, 'http://www.codelord.net$&', :if => Proc.new {|rack_env|
    rack_env['SERVER_NAME'] == 'codelord.net'
  }
  r301 %r{^/(20\d\d.*[^/])$}, '/$1/'
end

class SinatraStaticServer < Sinatra::Base  

  get(/.+/) do
    send_sinatra_file(request.path) {404}
  end

  not_found do
    send_file(File.join(File.dirname(__FILE__), 'public', '404.html'), {:status => 404})
  end

  def send_sinatra_file(path, &missing_file_block)
    file_path = File.join(File.dirname(__FILE__), 'public',  path)
    file_path = File.join(file_path, 'index.html') unless file_path =~ /\.[a-z]+$/i
    File.exist?(file_path) ? send_file(file_path) : missing_file_block.call
  end

end

run SinatraStaticServer
