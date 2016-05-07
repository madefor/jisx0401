# generate pref code table

require 'json'
require 'fileutils'
require 'open-uri'

JSX0402_ALL_URL = "https://madefor.github.io/jisx0402/api/v1/all.json"

PREF_CODE = {"01" => {"en"=>"Hokkaido"},
             "02" => {"en"=>"Aomori"},
             "03" => {"en"=>"Iwate"},
             "04" => {"en"=>"Miyagi"},
             "05" => {"en"=>"Akita"},
             "06" => {"en"=>"Yamagata"},
             "07" => {"en"=>"Fukushima"},
             "08" => {"en"=>"Ibaraki"},
             "09" => {"en"=>"Tochigi"},
             "10" => {"en"=>"Gunma"},
             "11" => {"en"=>"Saitama"},
             "12" => {"en"=>"Chiba"},
             "13" => {"en"=>"Tokyo"},
             "14" => {"en"=>"Kanagawa"},
             "15" => {"en"=>"Niigata"},
             "16" => {"en"=>"Toyama"},
             "17" => {"en"=>"Ishikawa"},
             "18" => {"en"=>"Fukui"},
             "19" => {"en"=>"Yamanashi"},
             "20" => {"en"=>"Nagano"},
             "21" => {"en"=>"Gifu"},
             "22" => {"en"=>"Shizuoka"},
             "23" => {"en"=>"Aichi"},
             "24" => {"en"=>"Mie"},
             "25" => {"en"=>"Shiga"},
             "26" => {"en"=>"Kyoto"},
             "27" => {"en"=>"Osaka"},
             "28" => {"en"=>"Hyogo"},
             "29" => {"en"=>"Nara"},
             "30" => {"en"=>"Wakayama"},
             "31" => {"en"=>"Tottori"},
             "32" => {"en"=>"Shimane"},
             "33" => {"en"=>"Okayama"},
             "34" => {"en"=>"Hiroshima"},
             "35" => {"en"=>"Yamaguchi"},
             "36" => {"en"=>"Tokushima"},
             "37" => {"en"=>"Kagawa"},
             "38" => {"en"=>"Ehime"},
             "39" => {"en"=>"Kochi"},
             "40" => {"en"=>"Fukuoka"},
             "41" => {"en"=>"Saga"},
             "42" => {"en"=>"Nagasaki"},
             "43" => {"en"=>"Kumamoto"},
             "44" => {"en"=>"Oita"},
             "45" => {"en"=>"Miyazaki"},
             "46" => {"en"=>"Kagoshima"},
             "47" => {"en"=>"Okinawa"},
            }

def make_pref_hash(json)
  pref_code = nil
  pref_hash = {}
  json.each do |code, val|
    next if code[0,2] == pref_code
    pref_code = code[0,2]
    pref_hash[pref_code] = {"ja"=>val["prefecture"],
                            "ja-kana"=>val["prefecture_kana"]}
  end
  pref_hash
end

def gen_pref_json
  jisx0402 = nil
  open(JSX0402_ALL_URL) do |f|
    jisx0402 = JSON.load(f)
  end
  pref_hash = make_pref_hash(jisx0402)
  PREF_CODE.each do |code, val|
    PREF_CODE[code].merge!(pref_hash[code])
  end
  
  FileUtils.mkdir_p("api/v1")
  File.open("api/v1/jisx0401.json", "wb") do |f|
    f.write JSON.dump(PREF_CODE)
  end

  pref_code_ja = PREF_CODE.map{|code, hash| [code, hash["ja"]]}.to_h
  File.open("api/v1/jisx0401-ja.json", "wb") do |f|
    f.write JSON.dump(pref_code_ja)
  end

  pref_code_en = PREF_CODE.map{|code, hash| [code, hash["en"]]}.to_h
  File.open("api/v1/jisx0401-en.json", "wb") do |f|
    f.write JSON.dump(pref_code_en)
  end
end

task :default => :gen_json

desc "generate JSON file of prefecture code"
task :gen_json do
  gen_pref_json
end
