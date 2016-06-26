# -*- encoding: Shift_JIS -*-
require 'rubygems'
require 'mechanize'
require 'pp'

DEL_PASS = "2357"

module Gazo
  module_function
  def upload(img)
    agent = Mechanize.new
    agent.keep_alive = false
    agent.max_history = 1
    agent.open_timeout = 60
    agent.read_timeout = 180
    agent.verify_mode = OpenSSL::SSL::VERIFY_NONE

    targetURI = "http://s1.gazo.cc/" # URLの編集

    agent.get(targetURI) do |page| #webPageの取得

      page.form_with(name: 'Form') do |form|
        form.file_upload.file_name = img
        form.field_with(:name => 'pass').value = DEL_PASS
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
    targetURI

    agent.get(targetURI) do |page| #webPageの取得
      page.search("//tr/td[@class='file']/a").each do |file|
        @file_no << file.inner_text.gsub(/(\d+)\.(.+)/,'\1')
      end

      page.form_with(name: 'Del') do |form|
        @file_no.each do |no|
          form.field_with(name: 'delno').value = no
          form.field_with(name: 'delpass').value = DEL_PASS
          form.submit
          sleep(0.5)
          puts no
        end

      end

    end
    puts "done"
  end

  def img_file(img_sel)
    arr = []
    File.open(img_sel).each do |line|
      arr << line.chomp
    end
    return arr
  end

  def multi_upload(img_arr)
    img_arr.each do |img|
      puts file = "./img_dir/" + img
      if File.exist?(file)
        Gazo.upload(file)
      else
        puts "not Exist"
      end
      sleep(1+[*1..4].sample)
    end
  end

end

#pp arr = Gazo.img_file("./img_select.txt")

#Gazo.multi_upload(arr)
#Gazo.delete

