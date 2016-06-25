# -*- encoding: Shift_JIS -*-
require 'rubygems'
require 'mechanize'
require 'pp'

module Gazo
  module_function
  def upload
    agent = Mechanize.new
    agent.keep_alive = false
    agent.max_history = 1
    agent.open_timeout = 60
    agent.read_timeout = 180
    agent.verify_mode = OpenSSL::SSL::VERIFY_NONE

    targetURI = "http://s1.gazo.cc/" # URLの編集
    puts targetURI

    agent.get(targetURI) do |page| #webPageの取得

      page.form_with(name: 'Form') do |form|
        form.file_upload.file_name = './img/4774158968.jpg'
        form.field_with(:name => 'pass').value = "2357"
        form.submit
      end

    end

    puts("done")
  end

  def delete
    @file_no=[]
    agent = Mechanize.new
    agent.keep_alive = false
    agent.max_history = 1
    agent.open_timeout = 60
    agent.read_timeout = 180
    agent.verify_mode = OpenSSL::SSL::VERIFY_NONE

    targetURI = "http://s1.gazo.cc/" # URLの編集
    puts targetURI

    agent.get(targetURI) do |page| #webPageの取得
      page.search("//tr/td[@class='file']/a").each do |file|
        @file_no << file.inner_text.gsub(/(\d+)\.(.+)/,'\1')
      end

      page.form_with(name: 'Del') do |form|
        @file_no.each do |no|
          form.field_with(name: 'delno').value = no
          form.field_with(name: 'delpass').value = "2357"
          form.submit
          sleep(0.5)
          puts no
        end

      end

    end
    puts "done"
  end
end

Gazo.delete
