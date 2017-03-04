#!/bin/bash

# ホームフォルダ
HOME=~/max3tb/data/develop/sh/enavi
export HOME

# ログフォルダ
DT=`date +"%Y%m%d%H%M%S"`
export DT
LOGDIR="${HOME}/log"
export LOGDIR

# 処理
function proc() {
	# 空行無視
	if [ "$1" = "" ]
	then
		return
	fi
	
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
export -f proc

#proc "0500"
# 船橋エリア
#proc "0510"
cat ${HOME}/arealist.txt | egrep -v "^#" | xargs -I % bash -c "proc %"

