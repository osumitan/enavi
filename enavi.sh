#!/bin/sh

# ホームフォルダ
HOME=~/max3tb/data/develop/sh/enavi

# ログフォルダ
DT=`date +"%Y%m%d%H%M%S"`
LOGDIR="${HOME}/log"

# 処理
proc() {
	# ID
	ID=$1
	echo "■ ■ ■ ID=${ID} ■ ■ ■"

	# ログファイル
	LOGFILE="${LOGDIR}/enavi_${ID}_${DT}.log"

	# URL
	URL="http://www.es-navi.com/list/list.cgi?num=${ID}"

	# ログを作成
	echo "■ ■ ■ ログを作成 ■ ■ ■"
	wget -O - "${URL}" 2>/dev/null | gawk -f "${HOME}/enavi.awk" > ${LOGFILE}

	# 前回と比較
	echo "■ ■ ■ 前回と比較 ■ ■ ■"
	ls ${LOGDIR}/*${ID}* | tail -2 | gawk 'BEGIN{a=0;}{if(a<2) b[++a]=$0;}END{printf("diff \"%s\" \"%s\"\n",b[1],b[2]);}' | bash

	# クリーン
	echo "■ ■ ■ クリーン ■ ■ ■"
	ls -r ${LOGDIR}/*${ID}* | gawk 'BEGIN{a=0;}{if(a>=2){printf("rm -f %s\n",$0);}a++;}' | bash
}

# 千葉エリア
proc "0500"
# 船橋エリア
proc "0510"


