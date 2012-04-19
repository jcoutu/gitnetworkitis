require 'rubygems'
require 'sinatra'
require 'oauth2' # ~> 0.5.0
require 'json'

def client
  OAuth2::Client.new('CLIENT ID', 'SECRET',
                     :ssl => {:ca_file => '/etc/ssl/ca-bundle.pem'},
                     :site => 'https://api.github.com',
                     :authorize_url => 'https://github.com/login/oauth/authorize',
                     :token_url => 'https://github.com/login/oauth/access_token')
end

get "/" do
  %(<p>Update the <code>#new_client</code> method in the sinatra app and <a href="/auth/github">try to authorize</a>.</p>)
end

get '/auth/github' do
  url = client.auth_code.authorize_url(:redirect_uri => redirect_uri, :scope => 'user')
  puts "Redirecting to URL: #{url.inspect}"
  redirect url
end

get '/auth/github/callback' do
  puts params[:code]
  begin
    access_token = client.auth_code.get_token(params[:code], :redirect_uri => redirect_uri)
    user = JSON.parse(access_token.get('/user').body)
    "<p>Your OAuth access token: #{access_token.token}</p><p>Your extended profile data:\n#{user.inspect}</p>"
  rescue OAuth2::Error => e
    %(<p>Outdated ?code=#{params[:code]}:</p><p>#{$!}</p><p><a href="/auth/github">Retry</a></p>)
  end
end

def redirect_uri(path = '/auth/github/callback', query = nil)
  uri = URI.parse(request.url)
  uri.path  = path
  uri.query = query
  uri.to_s
end