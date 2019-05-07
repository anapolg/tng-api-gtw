## Copyright (c) 2015 SONATA-NFV, 2017 5GTANGO [, ANY ADDITIONAL AFFILIATION]
## ALL RIGHTS RESERVED.
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##
## Neither the name of the SONATA-NFV, 5GTANGO [, ANY ADDITIONAL AFFILIATION]
## nor the names of its contributors may be used to endorse or promote
## products derived from this software without specific prior written
## permission.
##
## This work has been performed in the framework of the SONATA project,
## funded by the European Commission under Grant number 671517 through
## the Horizon 2020 and 5G-PPP programmes. The authors would like to
## acknowledge the contributions of their colleagues of the SONATA
## partner consortium (www.sonata-nfv.eu).
##
## This work has been performed in the framework of the 5GTANGO project,
## funded by the European Commission under Grant number 761493 through
## the Horizon 2020 and 5G-PPP programmes. The authors would like to
## acknowledge the contributions of their colleagues of the 5GTANGO
## partner consortium (www.5gtango.eu).
# frozen_string_literal: true
# encoding: utf-8
require 'rack'
require 'faraday'
require 'tng/gtk/utils/logger'

class Getter
  LOGGER=Tng::Gtk::Utils::Logger
  LOGGED_COMPONENT=self.name
  include Utils
  attr_accessor :app
  
  def initialize(app, options= {})
    @app = app
  end

  def call(env)
    msg = '#call'
    request = Rack::Request.new(env)  
    
    return @app.call(env) unless request.get?

    # Process GET requests
    LOGGER.debug(component:LOGGED_COMPONENT, operation:msg, message:'Calling '+env['5gtango.sink_path'])
    connection = Faraday.new(env['5gtango.sink_path']) do |conn|
      # Last middleware must be the adapter:
      conn.adapter :net_http
    end
    params = env['QUERY_STRING'].empty? ? {} : Rack::Utils.parse_nested_query(env['QUERY_STRING'])     
    LOGGER.debug(component:LOGGED_COMPONENT, operation:msg, message:"Params #{params}")

    begin
      # Still need to choose which headers should passed
      response = connection.get(env['5gtango.sink_path'], params, {'Content-Type' => request.content_type}) do |req|
        req.headers['X-User-Name'] = env.fetch('5gtango.user.name', '')
        req.headers['X-User-Email'] = env.fetch('5gtango.user.email', '')
      end
      LOGGER.debug(component:LOGGED_COMPONENT, operation:msg, message:"Response was #{response.status}, #{response.headers}, #{response.body}")
      return respond(response.status, response.headers, response.body)
    rescue Faraday::Error::ConnectionFailed => e
      LOGGER.debug(component:LOGGED_COMPONENT, operation:msg, message:"The server at #{env['5gtango.sink_path']} is either unavailable or is not currently accepting requests. Please try again in a few minutes.")
      return not_found("No response by GETing #{env['5gtango.sink_path']}"+ (params == {} ? "" : " with params #{params}"))
    end
  end
end
