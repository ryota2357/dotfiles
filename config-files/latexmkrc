#!/usr/bin/env perl

# texファイルをコンパイルするコマンドの設定
#  -shell-escape  : mintedパッケージ(コードのsyntax highlight)で必要
#  -synctex=1     : SyncTeX を有効に
#  -halt-on-error : コンパイル中にエラーが発生した場合、コンパイルを終了する
$latex = 'uplatex -shell-escape -synctex=1 -halt-on-error';

#  -interaction=batchmode : コンパイル中にエラーが起きても、ユーザーにどう処理するかの指示を求めずにコンパイルを続行する
$latex_silent = 'uplatex -shell-escape -synctex=1 -halt-on-error -interaction=batchmode';

# BiblatexのバックエンドにBibTeXを使用するときのコマンドを指定する
$bibtex = 'upbibtex %O %B';

# Bibtexのバックエンドにbiberを使用するときのコマンドを指定
#  –bblencoding=utf8 : bblファイル（参考文献ファイル）の文字コードをUTF-8に
#  -u                : 入力ファイルの文字コードをUTF-8に
#  -U                : 出力ファイルの文字コードをUTF-8に
#  –output_safechars : ユニコード文字をLaTeXの命令を使ってエンコードした形で出力させる
$biber = 'biber --bblencoding=utf8 -u -U --output_safechars %O %S';

# LaTeXにより出力されたDVIファイルをPDFファイルに変換するコマンドの設定
$dvipdf = 'dvipdfmx %O -o %D %S';

# 索引を作成するときのコマンドを指定 (\usepackage{makeidx}を使うときに必要になる)
$makeindex = 'upmendex %O -o %D %S';

# 最大何回コンパイルするかを指定
$max_repeat = 5;

# PDFの出力形式を指定
#  0 : $latexにより dviファイルを生成、PDFを出力しない
#  1 : $pdflatexを使って、DVIファイルなどを経由せずに直接PDFを作成
#  2 : $latexにより生成されたDVIファイルを$dvipsによりPSファイルに変換したあと、$ps2pdfによりPDFを作成
#  3 : $latexにより dviファイルを生成し、$dvipdfによりPDFを作成
#  4 : $lualatexにより直接PDFを作成
#  5 : $xelatexによりDVIを生成後、$xdvipdfmxによりPDFを作成
$pdf_mode = 3;

# latexmk -pvc を実行時に昔のデータをいくつ残しておくかを指定 (0だと残さない)
$pvc_view_file_via_temporary = 0;

# PDFのプレビューを表示するためのプログラムを指定
$pdf_previewer = "open -ga /Applications/Skim.app";
