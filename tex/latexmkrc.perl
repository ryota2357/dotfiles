#!/usr/bin/env perl

# texファイルをコンパイルするコマンドの設定
# -synctex=1：SyncTeX を有効に (SyncTeX対応のビューア(Skim等)からエディタにジャンプできる機能)
$latex            = 'platex -synctex=1 -halt-on-error';


$latex_silent     = 'platex -synctex=1 -halt-on-error -interaction=batchmode';
$bibtex           = 'pbibtex';
$biber            = 'biber --bblencoding=utf8 -u -U --output_safechars';
$dvipdf           = 'dvipdfmx %O -o %D %S';
$makeindex        = 'mendex %O -o %D %S';
$max_repeat       = 5;
$pdf_mode         = 3;
$pvc_view_file_via_temporary = 0;
$pdf_previewer    = "open -ga /Applications/Skim.app";
