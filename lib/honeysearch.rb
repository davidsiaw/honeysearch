# encoding: utf-8
require "honeysearch/version"

require 'uri'
require 'net/http'

module Honeysearch
  class Error < StandardError; end
  
  SEARCH_URL='https://karaoke.mashup.jp/search_result.php'

  class Search
    attr_reader :page

    def initialize(term, page=0)
      @term = term
      @page = page
    end

    def res
      @res ||= begin
        uri = URI("#{SEARCH_URL}?p=#{@page}")
        Net::HTTP.post_form(
          uri,
          sel_rows1: 30,
          topsearch_box: @term,
          sel_rows2: 30,
          s_title: '',
          s_singer: '',
          s_intro: '',
          s_tieup: '',
          search_genre: 0,
          sel_search_genre: 0,
          method: 0
        )
      end
    end

    def body
      @body ||= res.body.force_encoding('UTF-8')
    end

    def result
      body
    end

    def more?
      body.include?('次の30曲')
    end

    def total_number
      body.match(/検索結果\uff1a(?<number>[0-9]+)曲/)[:number].to_i
    end
  end

  class SongData
    def initialize(rawdata)
      @rawdata = rawdata
    end

    def splitdata
      @splitdata ||= begin
        res = []
        @rawdata.scan(%r{<li>(?<text>[^<]+)</li>}) do |x|
          res << x.first
        end
        res
      end
    end

    def artist
      splitdata[0]
    end

    def title
      splitdata[1]
    end
    
    def number
      splitdata[2]
    end
    
    def lyrics
      splitdata[3]
    end
    
    def tieup
      splitdata[4]
    end
    
    def genre
      splitdata[5]
    end

    def inspect
      "#<SongData: #{number} (#{artist}, #{title})>"
    end
  end

  class Parser
    def initialize(result)
      @result = result
    end

    def chopped_text
      res = []
      @result.split('<ul id="search_name" class="search_list">')[1..-1].each do |page|
        doc = page.split('<div id="search_result" class="pc_none">').first
        doc.split('<ul class="search_list">').each do |x|
          res << x
        end
      end
      res
    end

    def results
      res = []
      chopped_text[1..-1].each do |paragraph|
          res << SongData.new(paragraph)
      end
      res
    end
  end
end
