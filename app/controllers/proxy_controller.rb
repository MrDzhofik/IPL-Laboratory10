# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

# controller for getting input and showing answer
class ProxyController < ApplicationController
  def input; end

  def view
    @power = params[:power].to_i
    @side = params[:route]
    api_response = URI.open("http://localhost:3000/?format=xml&power=#{@power}")

    case @side
    when 'server'
      @result = xslt_transform(api_response).to_html
    when 'client'
      render xml: insert_browser_xslt(api_response).to_xml
    end
  end

  private

  def xslt_transform(data)
    doc = Nokogiri::XML(data)
    xslt = Nokogiri::XSLT(File.read("#{Rails.root}/app/helpers/server.xslt"))
    xslt.transform(doc)
  end

  def insert_browser_xslt(data)
    doc = Nokogiri::XML(data)
    xslt = Nokogiri::XML::ProcessingInstruction.new(doc, 'xml-stylesheet',
                                                    'type="text/xsl" href="/browser_render.xslt"')
    doc.root.add_previous_sibling(xslt)
    doc
  end
end
