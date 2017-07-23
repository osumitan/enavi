#!/usr/bin/python3

import sys
import io
from selenium import webdriver

# メイン
def main():
	# ドライバ初期化
	driver = webdriver.Chrome("./chromedriver")
	driver.set_window_size(800, 600)
	driver.set_window_position(520, 120)
	driver.set_page_load_timeout(20)
	# ページを開く
	driver.get(sys.argv[1])
	# 店リストを出力
	divlist = driver.find_elements_by_css_selector("td.aB3 div")
	for i in range(len(divlist)):
		div = divlist[i]
		alist = div.find_elements_by_css_selector("a")
		if len(alist) == 0:
			continue
		a = alist[0]
		url = a.get_attribute("href")
		buf = io.StringIO(div.text)
		name = buf.readline().replace("\n", "")
		area = buf.readline().replace("\n", "")
		print("{}\t{}\t{}".format(name, area, url))

main()

