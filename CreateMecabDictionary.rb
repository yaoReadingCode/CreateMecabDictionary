require 'csv'

# 実行時の引数で読み込むファイルを指定
inputFileName = ARGV[0]

# 第2引数の指定があったら、その名前のファイルを作成
# 無ければ、output_{第一引数}でファイルを作る
outputFileName = ARGV[1] || "output_" << ARGV[0]

# フォルダを開く
CSV.open(outputFileName,"wb") do |csv|

	# フォルダに1行づつ書き込み
	CSV.foreach(inputFileName) do |row|
		title = row[0]
		furigana = row[1]
		category = row[2]

		# コストの計算
		cost = [-32768, (6000 - 200 *(furigana.length**1.3))].max.to_i

		# 書き込む行(配列)の作成
		line = "#{title},0,0,#{cost},名詞,一般,*,*,*,*,*,*,*,#{category}".split(",")

		# ファイル書き込み
		csv << line
	end
end

p "辞書ファイルを作成しました #{outputFileName}"